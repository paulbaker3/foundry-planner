package page

import (
	"github.com/paulbaker3/foundry-planner/app/config"
)

type Page struct {
	Cfg     config.Config
	Modules Modules
}

type Modules []Module
type Module struct {
	Cfg  config.Config
	Tpl  string
	Body interface{}
}
