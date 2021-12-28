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
			;~ ConsoleWrite("Key: " & $KeyValues[$i2][0] & @CRLF & "Value: " & $KeyValues[$i2][1] & @CRLF)
			$values = StringSplit($KeyValues[$i2][1], "|")
			$file = $values[1]
			$file = StringReplace($file, "%ProgramFiles%", @ProgramFilesDir)
			$file = StringReplace($file, "%ProgramFilesX86%", @ProgramFilesDir & " (x86)")
			;~ ConsoleWrite($file & @CRLF)
			$lnk = $values[2]
			;~ ConsoleWrite($lnk & @CRLF)
			$lnk = StringReplace($lnk, "<Category>", $SectionNames[$i])
			$lnk = StringReplace($lnk, "<Link Name>", $KeyValues[$i2][0])
			;~ ConsoleWrite($lnk & @CRLF)
			If UBound($values) > 3 Then 
				$workdir = $values[3] 
			Else 
				$workdir = "" 
			EndIf
			If UBound($values) > 4 Then 
				$args = $values[4] 
			Else 
				$args = "" 
			EndIf
			If UBound($values) > 5 Then 
				$desc = $values[5] 
			Else 
				$desc = "" 
			EndIf
			If UBound($values) > 6 Then 
				$icon = $values[6] 
			Else 
				$icon = "" 
			EndIf
			If UBound($values) > 7 Then 
				$hotkey = $values[7] 
			Else 
				$hotkey = "" 
			EndIf
			If UBound($values) > 8 Then 
				$iconnumber = $values[8] 
			Else 
				$iconnumber = "" 
			EndIf
			If UBound($values) > 9 Then 
				$state = $values[9] 
			Else 
				$state = "" 
			EndIf
			If StringLeft($file, 11) == "Start Menu\" Then
				$commonfile = @StartMenuCommonDir & StringReplace($file, "Start Menu", "")
				$commonlnk = @StartMenuCommonDir & StringReplace($lnk, "Start Menu", "")
				If FileExists($commonfile) Then FileCopy($commonfile, $commonlnk, 9)
				$userfile = @StartMenuDir & StringReplace($file, "Start Menu", "")
				$userlnk = @StartMenuDir & StringReplace($lnk, "Start Menu", "")
				If FileExists($userfile) Then FileCopy($userfile, $userlnk, 9)
			ElseIf FileExists($file) Then
				$commonlnk = @StartMenuCommonDir & StringReplace($lnk, "Start Menu", "")
				DirCreate(GetDir($commonlnk))
				;~ ConsoleWrite(GetDir($commonlnk) & @CRLF)
				FileCreateShortcut($file, $commonlnk)
				;~ FileCreateShortcut("C:\Program Files\IrfanView\i_view64.exe", "C:\ProgramData\Microsoft\Windows\Start Menu\Imaging\IrfanView.lnk")
			EndIf
		Next
	EndIf
Next
;~ Sleep(10000)

Func GetDir($sFilePath)

    Local $aFolders = StringSplit($sFilePath, "\")
    Local $iArrayFoldersSize = UBound($aFolders)
    Local $FileDir = ""

    If (Not IsString($sFilePath)) Then
        Return SetError(1, 0, -1)
    EndIf

    $aFolders = StringSplit($sFilePath, "\")
    $iArrayFoldersSize = UBound($aFolders)

    For $i = 1 To ($iArrayFoldersSize - 2)
        $FileDir &= $aFolders[$i] & "\"
    Next

    Return $FileDir

EndFunc

;~ FileCreateShortcut("file", "lnk", "workdir", "args", "desc", "icon", "hotkey", "icon number", "state")