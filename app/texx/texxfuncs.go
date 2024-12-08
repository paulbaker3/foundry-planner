// TODO: Why do we need this file?
package texx

import "github.com/paulbaker3/foundry-planner/app/tex"

// EmphCell is a function that returns a TeX code for an emphasized cell.
// It is a wrapper for the tex.CellColor and tex.TextColor functions.
// TODO: Can this move to the tex package?
func EmphCell(text string) string {
	return tex.CellColor("black", tex.TextColor("white", text))
}
