#AutoIt3Wrapper_Change2CUI=y
#AutoIt3Wrapper_Res_Icon_Add=icon.ico

;~ ConsoleWrite("Hello World" & @CRLF)
;~ TODO
;~ 
;~ 
;~ 
;~ 
;~ 
;~ 
;~ 

$FileName = @ScriptDir & "\StartMenu.ini"
$SectionNames = IniReadSectionNames($FileName)

For $i = 1 To $SectionNames[0]
	ConsoleWrite("[" & $SectionNames[$i] & "]" & @CRLF)
	$KeyValues = IniReadSection($FileName, $SectionNames[$i])
	If UBound($KeyValues) > 1 Then
		For $i2 = 1 To $KeyValues[0][0]
			ConsoleWrite("Key: " & $KeyValues[$i2][0] & @CRLF & "Value: " & $KeyValues[$i2][1] & @CRLF)
			$values = StringSplit($KeyValues[$i2][1], "|")
			$file = $values[1]
			;~ ConsoleWrite($file & @CRLF)
			$lnk = $values[2]
			;~ ConsoleWrite($lnk & @CRLF)
			$lnk = StringReplace($lnk, "<Category>", $SectionNames[$i])
			$lnk = StringReplace($lnk, "<Link Name>", $KeyValues[$i2][0])
			;~ ConsoleWrite($lnk & @CRLF)
			If StringLeft($file, 11) == "Start Menu\" Then
				$commonfile = @StartMenuCommonDir & StringReplace($file, "Start Menu", "")
				$commonlnk = @StartMenuCommonDir & StringReplace($lnk, "Start Menu", "")
				If FileExists($commonfile) Then FileCopy($commonfile, $commonlnk, 9)
				$userfile = @StartMenuDir & StringReplace($file, "Start Menu", "")
				$userlnk = @StartMenuDir & StringReplace($lnk, "Start Menu", "")
				If FileExists($userfile) Then FileCopy($userfile, $userlnk, 9)
			EndIf
			;~ FileCreateShortcut()
		Next
	EndIf
Next

;~ FileCreateShortcut("file", "lnk", "workdir", "args", "desc", "icon", "hotkey", "icon number", "state")