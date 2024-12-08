#!/usr/bin/env bash

set -eo pipefail

if [ -z "$PLANNERGEN_BINARY" ]; then
  export GO_CMD="go run cmd/plannergen/plannergen.go"
else
  export GO_CMD="$PLANNERGEN_BINARY"
  echo "Building using plannergen binary at \"${PLANNERGEN_BINARY}\""
fi

if [ -z "$TEMPLATE" ]; then
  if [ -z "$CFG" ]; then
    echo "Either TEMPLATE or CFG must be set"
    exit 1
  fi
  # If TEMPLATE is not set, assume CFG is provided
  # echo "Using provided CFG: $CFG"
else
  # Map TEMPLATE to CFG values
  case "$TEMPLATE" in
    scribe_breadcrumb_daily)
      CFG="cfg/base.yaml,cfg/kscribe.breadcrumb.default.dailycal.yaml"
      ;;
    scribe_breadcrumb_default)
      CFG="cfg/base.yaml,cfg/kscribe.breadcrumb.default.yaml"
      ;;
    remark_mos)
      CFG="cfg/base.yaml,cfg/rm2.mos.default.yaml"
      ;;
    remark_mos_daily)
      CFG="cfg/base.yaml,cfg/rm2.mos.default.dailycal.yaml"
      ;;
    *)
      echo "Unknown TEMPLATE: $TEMPLATE"
      exit 1
      ;;
  esac
  echo "Using CFG mapped from TEMPLATE: $CFG"
fi

echo "Running $GO_CMD with CFG: $CFG"

if [ -z "$PREVIEW" ]; then
  eval $GO_CMD --config "${CFG}"
else
  eval $GO_CMD --preview --config "${CFG}"
fi




nakedname=$(echo "${CFG}" | rev | cut -d, -f1 | cut -d'/' -f 1 | cut -d'.' -f 2-99 | rev)

if [ -n "${TRANSLATION}" ]; then
  echo "Applying translations"
  python3 translate.py ${TRANSLATION}
fi

_passes=(1)

if [[ -n "${PASSES}" ]]; then
  # shellcheck disable=SC2207
  _passes=($(seq 1 "${PASSES}"))
  echo "Preparing to run ${PASSES} passes"
fi

for _ in "${_passes[@]}"; do
  # echo "Running xelatex pass $(_)"
  xelatex \
    -file-line-error \
    -interaction=nonstopmode \
    -synctex=1 \
    -output-directory=./out \
    "out/${nakedname}.tex"
done

if [ -n "${NAME}" ]; then
  echo "Copying ./out/${nakedname}.pdf to ./pdfs/${NAME}.pdf"
  cp "out/${nakedname}.pdf" "pdfs/${NAME}.pdf"
  echo "./pdfs/created ${NAME}.pdf"
else
  TIMESTAMP=$(date +%s)  # Get the current UNIX timestamp
  echo "Copying ./out/${nakedname}.pdf to ./pdfs/${TIMESTAMP}.pdf"
  cp "out/${nakedname}.pdf" "pdfs/${TIMESTAMP}.pdf"
  echo "created ./pdfs/${TIMESTAMP}.pdf"
fi
