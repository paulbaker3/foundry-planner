package texx

import "github.com/paulbaker3/foundry-planner/app/tex"

func EmphCell(text string) string {
	return tex.CellColor("black", tex.TextColor("white", text))
}
