﻿SendMode Input
SetWorkingDir %A_ScriptDir%
configFile = OneButtonMacro.config
if FileExist(configFile) {
	file := FileOpen(configFile, "r")
	fileContents := file.Read()
	fileContentsSplitted := StrSplit(fileContents, "`n")
	userHotkey := fileContentsSplitted[1]
	userMacro := fileContentsSplitted[2]
	file.Close()
} else {
	userHotkey := 2
	userMacro := 54321
}
Gui, Add, Text,, 핫키 :
Gui, Add, Hotkey, vhot1, %userHotkey%
Gui, Add, Text,, 입력 매크로 :
Gui, Add, Edit, vedit1 w135, %userMacro%
Gui, Add, Button, gbtn, 적용
Gui, Submit, Nohide
Gui, -MaximizeBox -MinimizeBox
Gui, show, W175
enable := false
Return

btn:
	Gui, Submit, Nohide
	if enable {
		enable := false
		Hotkey, $%hot1%, hotkey1, off
		GuiControl, Enabled, hot1
		GuiControl, Enabled, edit1
		GuiControl,, btn, 적용
	}
	else {
		enable := true
		Hotkey, $%hot1%, hotkey1, on
		GuiControl, Disabled, hot1
		GuiControl, Disabled, edit1
		GuiControl,, btn, 해제

	}
	Gui, Submit, Nohide
Return

hotkey1:
	SendWithRandDelay(edit1)
return

SendWithRandDelay(str) {
	strSplitted := StrSplit(str)
	For i, c in strSplitted {
		Random, rand, 5, 15
		SendInput %c%
		Sleep rand
	}
}

GuiClose:
Gui, Submit, Nohide
userHotkey := hot1
userMacro := edit1
file := FileOpen(configFile, "w")
file.WriteLine(userHotkey)
file.Write(userMacro)
file.Close()
ExitApp