#MaxThreadsPerHotkey 3 ; Multiple threads to allow for looping and toggle
!s:: ; Toggle Script with Alt S
if running {
	running := false ; Stop running
	return
}
running := true

CoordMode Pixel ; ImageSearch relative to screen
CoordMode ToolTip ; ToolTip relative to screen
CoordMode Mouse ; ToolTip relative to screen

x1 := -1
y1 := -1
x2 := -1
y2 := -1
defineTopLeft := true
defineBottomRight := false

ToolTip Please click the top left region of the game screen
; Wait for regions to be defined
Loop {
	if (!defineTopLeft and !defineBottomRight) {
		break
	}
	Sleep 50
}
ToolTip

Loop {
	ImageSearch, x, y, x1, y1, x2, y2, *15 *TransWhite Turtle.png
	if (ErrorLevel = 0) {
		MouseClick, Left, x + 20, y + 20, 1, 0 ; Found turtle, click
		Sleep 100
	}
	if not running
		break ; Stop running when the running variable is set to false
}
running := false ; Ensure that there is no other thread running
return

~LButton:: ; On left click
CoordMode Mouse
if defineTopLeft {
	MouseGetPos x1, y1
	defineBottomRight := true
	defineTopLeft := false
	ToolTip Please click the bottom right region of the game screen
}
else if defineBottomRight {
	MouseGetPos x2, y2
	defineBottomRight := false
}
