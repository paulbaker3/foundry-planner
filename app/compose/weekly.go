package compose

import (
	"github.com/paulbaker3/foundry-planner/app/components/cal"
	"github.com/paulbaker3/foundry-planner/app/components/page"
	"github.com/paulbaker3/foundry-planner/app/config"
)

func Weekly(cfg config.Config, tpls []string) (page.Modules, error) {
	modules := make(page.Modules, 0, 53)
	year := cal.NewYear(cfg.WeekStart, cfg.Year)

	for _, week := range year.Weeks {
		modules = append(modules, page.Module{
			Cfg: cfg,
			Tpl: tpls[0],
			Body: map[string]interface{}{
				"Year":         year,
				"Week":         week,
				"Breadcrumb":   week.Breadcrumb(),
				"HeadingMOS":   week.HeadingMOS(),
				"SideQuarters": year.SideQuarters(week.Quarters.Numbers()...),
				"SideMonths":   year.SideMonths(week.Months.Months()...),
				"Extra":        week.PrevNext().WithTopRightCorner(cfg.ClearTopRightCorner),
				"Extra2":       extra2(cfg.ClearTopRightCorner, false, false, nil, 0),
			},
		})
	}

	return modules, nil
}
