# latex-yearly-planner

PDF planner designed for e-ink devices.

See [original discussions topic](https://github.com/kudrykv/latex-yearly-planner/discussions) for available planners and their variations.

See [forked discussions topic](https://github.com/paulbaker3/foundry-planner/discussions) for ongoing support and feature requests. 

## Quick Start Guide
Here are the steps to quickly get the project up and running.

* Note: if you are here just for the planners you can find pre-generated
 planners in [2022-2032 Planners Discussions](https://github.com/paulbaker3/foundry-planner/discussions/57).

For the tinkerers, read on.

The following was tested with [POP_OS 22.04.1 LTS](https://pop.system76.com/) under [Virtualbox](https://www.virtualbox.org/) version 6.1

### Install Dependencies
1. [Go Language](https://go.dev/dl/)
2. [LaTex](https://miktex.org/download) & [PDFLaTeX](https://www.latex-project.org/get/)
3. From the project directory, run the following command after updating
 'PLANNER_YEAR' below. This should generate the PDF in the 'out' directory.

```bash
PLANNER_YEAR=2022 \
PASSES=1 \
CFG="cfg/base.yaml,cfg/template_breadcrumb.yaml,cfg/sn_a5x.breadcrumb.default.yaml" \
NAME="sn_a5x.breadcrumb.default" \
./single.sh
```

[Source](https://github.com/paulbaker3/foundry-planner/discussions/34#discussioncomment-3128344)

4. Check the "out" directory for the 'pdf' planner. To move it to your device
, follow the manufacturer's instructions on how to load a PDF on your device.

If you encounter any problems related to '.sty' files you likely need to
 install some Latex related dependencies. Copying the error and search using
  your favorite search engine should get you on track to resolving the
   dependency issues. All the best!

### Alternative install

Instead of installing the dependencies manually, this repository is defined as a Nix flake which specifies fixed versions of all the required dependencies. 

1. [Install Nix](https://nixos.org/download.html)
2. Build a planner pdf using `nix build`
3. Or, if you want to develop the code, enter a shell with all the dependencies present using `nix develop`

# Working with the code

## Generating Novel Planners

### Command Structure 

Planners are generated using variables to configure each aspect of the desired output:
* `PLANNER_YEAR` - The year that will be produced
* `PASSES` - Not sure what this does
* `CFG` - The configuration files that will be used. Not sure if order matters. 
* `NAME` - The output file name that will be dropped into the `/out` directory
* `root` - The file `.sh` file is what initiates the generation process

### Examples
```bash
# This will produce 2025's entire year planner
PLANNER_YEAR=2025 \
PASSES=1 \
CFG="cfg/base.yaml,cfg/template_breadcrumb.yaml,cfg/sn_a5x.breadcrumb.default.yaml" \
NAME="sn_a5x.breadcrumb.default" \
./single.sh
```

```bash
# This will produce a Scribe formated daily calendar with the breadcrumb header
PLANNER_YEAR=2025 \
PASSES=1 \
CFG="cfg/base.yaml,cfg/template_breadcrumb.yaml,cfg/kscribe.breadcrumb.default.dailycal.yaml" \
NAME="scribe.2025.dailycal.breadcrumb.default" \
./single.sh
```

```bash
# This will produce a Scribe formated daily calendar with the breadcrumb header
PLANNER_YEAR=2025 \
PASSES=1 \
CFG="cfg/base.yaml,cfg/template_months_on_side.yaml,cfg/kscribe.breadcrumb.default.yaml" \
NAME="scribe.2025.dailycal.breadcrumb.default" \
./single.sh
```

```bash
# This will produce an abbreviated planner for 2028 in the root dir for development pursposes
# with these default configs
# CONFIG_FILES='cfg/base.yaml,cfg/template_months_on_side.yaml,cfg/sn_a5x.mos.default.yaml,cfg/sn_a5x.mos.default.dailycal.yaml'
./preview.sh 2028
```

```bash
# This will produce a Scribe formated daily calendar with the breadcrumb on the side
PLANNER_YEAR=2029 \
PASSES=1 \
CFG="cfg/base.yaml,cfg/template_months_on_side.yaml,cfg/sn_a5x.mos.default.yaml,cfg/sn_a5x.mos.default.dailycal.yaml" \
./single.sh
```


## Directory Structure

### root

### app

Core functions. Component definitions. Layouts. Consumption of configurations.

### cfg

Configuration for supported outputs.

### cmd

Single generation command: `cmd/plannergen/plannergen.go`

### examples

Example generated output. Organized by layout size and style. Not sure why so many examples though. Test data?

### out

Generated files. 

### tpls

Pre-configured commands (ie "Templates")

### translations

Translation mapping json files
   
# Preview examples
<img src="https://raw.githubusercontent.com/paulbaker3/foundry-planner/refs/heads/main/examples/pictures/sn_a5x.planner/01_annual.png" width="419">
<img src="https://raw.githubusercontent.com/paulbaker3/foundry-planner/refs/heads/main/examples/pictures/sn_a5x.planner/02_quarter.png" width="419">
<img src="https://raw.githubusercontent.com/paulbaker3/foundry-planner/refs/heads/main/examples/pictures/sn_a5x.planner/03_month.png" width="419">
<img src="https://raw.githubusercontent.com/paulbaker3/foundry-planner/refs/heads/main/examples/pictures/sn_a5x.planner/04_week.png" width="419">
<img src="https://raw.githubusercontent.com/paulbaker3/foundry-planner/refs/heads/main/examples/pictures/sn_a5x.planner/05_day.png" width="419">
<img src="https://raw.githubusercontent.com/paulbaker3/foundry-planner/refs/heads/main/examples/pictures/sn_a5x.planner/06_day_notes.png" width="419">
<img src="https://raw.githubusercontent.com/paulbaker3/foundry-planner/refs/heads/main/examples/pictures/sn_a5x.planner/07_day_reflect.png" width="419">
<img src="https://raw.githubusercontent.com/paulbaker3/foundry-planner/refs/heads/main/examples/pictures/sn_a5x.planner/08_todos_index.png" width="419">
<img src="https://raw.githubusercontent.com/paulbaker3/foundry-planner/refs/heads/main/examples/pictures/sn_a5x.planner/09_todos_page.png" width="419">
<img src="https://raw.githubusercontent.com/paulbaker3/foundry-planner/refs/heads/main/examples/pictures/sn_a5x.planner/10_notes_index.png" width="419">
<img src="https://raw.githubusercontent.com/paulbaker3/foundry-planner/refs/heads/main/examples/pictures/sn_a5x.planner/11_notes_page.png" width="419">
