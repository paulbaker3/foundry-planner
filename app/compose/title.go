package compose

import (
	"fmt"

	"github.com/paulbaker3/foundry-planner/app/components/page"
	"github.com/paulbaker3/foundry-planner/app/config"
)

func Title(cfg config.Config, tpls []string) (page.Modules, error) {
	if len(tpls) != 1 {
		return nil, fmt.Errorf("exppected one tpl, got %d %v", len(tpls), tpls)
	}

	return page.Modules{{Cfg: cfg, Tpl: tpls[0]}}, nil
}
