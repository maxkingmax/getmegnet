#Region ;**** 由 AccAu3Wrapper_GUI 创建指令 ****
#AccAu3Wrapper_Icon=项目2.ico
#AccAu3Wrapper_Outfile_x64=magnet.exe
#AccAu3Wrapper_Res_Fileversion=1.0.0.32
#AccAu3Wrapper_Res_Fileversion_AutoIncrement=p
#AccAu3Wrapper_Res_SaveSource=y
#AccAu3Wrapper_Res_Language=2052
#AccAu3Wrapper_Res_requestedExecutionLevel=None
#AccAu3Wrapper_Res_Icon_Add=项目12.ico
#AccAu3Wrapper_Res_Icon_Add=项目1.ico
#EndRegion ;**** 由 AccAu3Wrapper_GUI 创建指令 ****
#Region ;**** 参数创建于 ACNWrapper_GUI ****
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
;~ #AccAu3Wrapper_Res_Icon_Add=C:\Users\Administrator\Desktop\项目1.ico
#include <MsgBoxConstants.au3>
#include <Constants.au3>
#include <TrayConstants.au3> ; Required for the $TRAY_ICONSTATE_SHOW constant.
#include <array.au3>
#include <File.au3>
;~ #include <File.au3>
#include <Misc.au3>
;~ #include <Array.au3>
#include <File.au3>
Opt("TrayMenuMode", 3)
Opt("WinTitleMatchMode", 2)
_Singleton("test", 0)
Global $tttt = 0 , $beep=0
Local $brower[] = ["5", "115", "Internet Explorer", "Google Chrome", "edge", "[CLASS:Maxthon3Cls_MainFrm]"]

HotKeySet("!c", "ttt")
HotKeySet("^!S", "zhengli")
;~ TrayTip("使用说明", @CRLF & "快捷键:" & @CRLF & "模式切换:ALT+C" & @CRLF & "文件整理:CTRL+ALT+SHIFT+S", 20, 1)
HotKeySet("{F7}", "hot")
;~ HotKeySet("{F8}", "hot2")
HotKeySet("^!c", "hot3")


HotKeySet("+{F7}", "hot11")
;~ HotKeySet("+{F8}", "hot22")
;~ _ArrayDisplay($brower)


If Not FileExists(@ScriptDir & "\browerlist.txt") Then
	_FileWriteFromArray(@ScriptDir & "\browerlist.txt", $brower, 1)
Else
	_FileReadToArray(@ScriptDir & "\browerlist.txt", $brower)
EndIf



$plugexe=@ScriptDir&"\BTSO_GUI_x64.exe"



$stext=""

$clfile = "d:\CL_magnet.txt"

$aaa = 0




; The default tray menu items will not be shown and items are not checked when selected. These are options 1 and 2 for TrayMenuMode.

Local $idpause = TrayCreateItem("暂停(&P)")
Local $idAbout = TrayCreateItem("静音(&M)")
TrayItemSetState (-1,$TRAY_CHECKED)
TrayCreateItem("") ; Create a separator line.


Local $idopentxt = TrayCreateItem("打开文件(&P)...")
Local $idzhengli = TrayCreateItem("整理文件(&L)...")
Local $idcuttxt = TrayCreateItem("剪切所有链接(&U)")
TrayCreateItem("") ; Create a separator line.

Local $idplug=TrayCreateMenu("扩展")
Local $idplug1=TrayCreateItem("BTSO批量处理",$idplug)
TrayCreateItem("") ; Create a separator line.
;~ Local $idshuoming = TrayCreateItem("使用说明(&H)")
Local $idExit = TrayCreateItem("退出")

TraySetState(1) ; Show the tray menu.
TraySetClick(18) ; Show the tray menu when the mouse if hovered over the tray icon.





While 1
	Sleep(10)
;~ 	If  StringRegExp(ClipGet(), "[a-fA-F0-9]{40}") or  StringRegExp(ClipGet(), "[A-Z2-7]{32}")  Then
;~ 		FileWriteLine($clfile, 'magnet:?xt=urn:btih:' & ClipGet())
;~ 		TrayTip("捕获车牌号一枚", "你懂的", 2, 1)
;~ 		ClipPut("")
;~ 	EndIf

Select
	


	
	Case StringRegExp(ClipGet(),"magnet\:\?xt\=urn\:btih\:[a-fA-F0-9]{40}") Or StringRegExp(ClipGet(),"magnet\:\?xt\=urn\:btih\:[a-zA-Z2-7]{32}")
			FileWriteLine($clfile,  ClipGet())

		TrayTip("捕获车牌号一枚", "你懂的", 2, 1)
		ClipPut("")
	Case StringRegExp(ClipGet(), "[a-fA-F0-9]{40}") And StringLen(ClipGet())=40
				FileWriteLine($clfile, 'magnet:?xt=urn:btih:' & ClipGet())

		TrayTip("捕获车牌号一枚", "你懂的", 2, 1)
		ClipPut("")
		
EndSelect

		




;~ https://btso.pw/magnet/detail/hash/A2FCFF6AB4752E74BF12CDE7940EEB973266D9DF
;~ 	If StringLen(ClipGet()) = 75 And StringInStr(ClipGet(), "https://btso.pw/magnet/detail/hash/") Then
;~ 		FileWriteLine($clfile, 'magnet:?xt=urn:btih:' & StringRight(ClipGet(), 40))
;~ 		TrayTip("捕获btso.pw车牌号一枚", "你懂的", 2, 1)
;~ 		ClipPut("")
;~ 	EndIf



	Switch TrayGetMsg()
		Case $idExit ; Exit the loop.
			Exit
		Case $idpause
			$aaa=1
		Case $idAbout ; Display a message box about the AutoIt version and installation path of the AutoIt executable.
			ttt()
		Case $idzhengli
			zhengli()
		Case $idcuttxt
			$aaa=1
			cuttxt()
		Case $idopentxt
			openfile()
		Case $idplug1
			ShellExecute($plugexe)

;~ 		Case $idshuoming
;~ 			TrayItemSetState($idAbout, 128)
;~ 			TrayItemSetState($idExit, 128)
;~ 			TrayItemSetState($idzhengli, 128)
;~ 			TrayItemSetState($idshuoming, 128)
;~ 			TrayItemSetState($idopentxt, $tray_disable)

;~ 			TrayItemSetState($idpause, $tray_disable)
;~ 			TraySetState(4)


;~ 			MsgBox(0x40, "使用帮助", "快捷键:" & @CRLF & @CRLF & _
;~ 					'1.模式切换":ALT+C' & @CRLF & @CRLF & _
;~ 					"转换模式:将种子下载链接转换为磁力链接并保存(默认)" & @CRLF & "提取模式:将网页中的磁力链接进行提取并保存." & @CRLF & @CRLF & _
;~ 					'注意:运行"提取模式"后,将自动切换为"转换模式"' & @CRLF & @CRLF & _
;~ 					"2.快速转换并关闭Maxthon标签: F7" & @CRLF & @CRLF & _
;~ 					"3.快速提取并关闭Maxthon标签: F8" & @CRLF & @CRLF & _
;~ 					"4.整理文件:CTRL+ALT+SHIFT+S" & @CRLF & @CRLF & _
;~ 					"去除磁力链保存文件中的空行和重复项." & @CRLF & @CRLF & _
;~ 					"5.磁力链接文件保存位置:" & $clfile, 15) ; Find the folder of a full path.


;~ 			TrayItemSetState($idAbout, 64)
;~ 			TrayItemSetState($idExit, 64)
;~ 			TrayItemSetState($idzhengli, 64)
;~ 			TrayItemSetState($idshuoming, 64)
;~ 			TrayItemSetState($idopentxt, $tray_enable)
;~ 			TrayItemSetState($idpause, $tray_enable)
;~ 			TraySetState(8)









	EndSwitch



 If $aaa = 1 Then
			TraySetState(4)
			TraySetIcon(@ScriptName, -6)
;~ 			TrayItemSetState($idAbout, 128)
;~ 			TrayItemSetState($idExit, 128)
;~ 			TrayItemSetState($idzhengli, 128)
;~ 			TrayItemSetState($idshuoming, 128)
;~ 			TrayItemSetState($idopentxt, $tray_disable)
			TrayItemSetstate($idpause, $TRAY_CHECKED)
			TrayTip("", "已经暂停", 5, 1)
			TraySetToolTip("已暂停")
			While $aaa
;~ 				ConsoleWrite($aaa)
				Switch TrayGetMsg()
					Case $idpause
						$aaa = 0
						Case $idopentxt
						openfile()
						Case $idzhengli
					zhengli()
					Case $idcuttxt
					cuttxt()
					Case $idplug1
					ShellExecute($plugexe)
					Case $idExit
						Exit
				EndSwitch

			WEnd
			TraySetState(8)
			TraySetIcon("")
;~ 			TrayItemSetState($idAbout, 64)
;~ 			TrayItemSetState($idExit, 64)
;~ 			TrayItemSetState($idzhengli, 64)
;~ 			TrayItemSetState($idshuoming, 64)
;~ 			TrayItemSetState($idopentxt, $tray_enable)
			TrayItemSetstate($idpause, $TRAY_UNCHECKED)
			ClipPut("")
;~ 			TrayTip("", "已经恢复", 5, 1)
;~ 				TraySetToolTip("已恢复")
;~
Else
	main()

EndIf























WEnd





;~ _ArrayDisplay($brower)

Func hot11()
	$input = InputBox("请输入次数", " ", "10", "", 10, 20, @DesktopWidth / 2 - 5, @DesktopHeight / 5 - 20, 8)
	If $input <> "" Then
		$i = 1
		Do
			hot()
			$i += 1
			Sleep(800)
		Until $i > $input
	EndIf


EndFunc   ;==>hot11


Func hot22()
	$input = InputBox("请输入次数", " ", "10", "", 10, 20, @DesktopWidth / 2 - 5, @DesktopHeight / 5 - 20, 8)
	If $input <> "" Then
		$i = 1
		Do
			$tttt = 1
			hot()
			$i += 1
			Sleep(800)
		Until $i > $input
	EndIf

EndFunc   ;==>hot22

Func hot()
	$brow = 0
	_FileReadToArray(@ScriptDir & "\browerlist.txt", $brower)
	For $i = 1 To $brower[0]

		$w = WinActive($brower[$i], "")
;~  MsgBox(0,$w,$w)
		$brow = $w + $brow

	Next

;~   MsgBox(0,"oK",$brow)




	If $brow <> 0 Then
;~ 	MsgBox(0,"ok","ok")
		Send("^a")
		Send("^c")
;~ MouseClick("left")
		Send("^w")
		If $beep=1 Then Beep(4000, 500)
	EndIf
	main()
EndFunc   ;==>hot

Func hot3()
	$tttt = 1
	$brow = 0
	For $i = 1 To $brower[0]

		$w = WinActive($brower[$i], "")
;~  MsgBox(0,$w,$w)
		$brow = $w + $brow

	Next

;~   MsgBox(0,"oK",$brow)




	If $brow <> 0 Then
;~ 	MsgBox(0,"ok","ok")
;~ 	Send("^a")
		Send("^c")
;~ MouseClick("left")
;~ Send("^w")
	EndIf
	main()

EndFunc   ;==>hot3

Func hot2()
	$tttt = 1

	hot()


EndFunc   ;==>hot2









Func cuttxt()

	Local $aArray
	_FileReadToArray($clfile, $aArray, 0)
	_ArrayToClip($aArray, @CRLF)
	$hFileOpen = FileOpen($clfile, 2)
	FileClose($hFileOpen)
EndFunc   ;==>cuttxt

















Func zhengli()
	Local $aArray
;~ $filea=FileOpenDialog("选择需要整理的文本文件",@scriptdir,"文本文件 (*.txt)")

	TraySetState(4)
	$msg = MsgBox(0x4 + 0x20 + 0x100, "请确认", "确定要整理磁力链文件并去除重复链接吗?", 10)
	If $msg = 6 Then
;~ 	$filea=FileOpen($clfile,2)
		TraySetIcon(@ScriptName, -6)

		$filea = $clfile
		If Not @error Then
			_FileReadToArray($filea, $aArray)
;~ _ArrayDisplay($aArray, "$aArray Initial") ; Display the current array.
			If IsArray($aArray) Then
				Local $aArrayUnique = _ArrayUnique($aArray) ; Use default parameters to create a unique array.
;~ _ArrayDisplay($aArrayUnique, "$aArray Unique") ; Display the unique array.

				For $i = 1 To $aArrayUnique[0]
;~ If  StringRegExp($aArrayUnique[$i], "[A-Z0-9]{32}\R")  Then
;~ 					ConsoleWrite($aArrayUnique[$i])
;~ 						$aArrayUnique[$i] = 'magnet:?xt=urn:btih:' & $aArrayUnique[$i]
;~ 					EndIf
;~ If  StringRegExp($aArrayUnique[$i], "[a-fA-F0-9]{40}\R")  Then
;~ 					ConsoleWrite($aArrayUnique[$i])
;~ 						$aArrayUnique[$i] = 'magnet:?xt=urn:btih:' & $aArrayUnique[$i]
;~ 					EndIf

Select
	Case StringRegExp($aArrayUnique[$i], "[a-fA-F0-9]{40}\R")
		$aArrayUnique[$i] = 'magnet:?xt=urn:btih:' & $aArrayUnique[$i]
	Case StringRegExp($aArrayUnique[$i], "[A-Z0-9]{32}\R")
		$aArrayUnique[$i] = 'magnet:?xt=urn:btih:' & $aArrayUnique[$i]
EndSelect





				Next

;~ 				_ArrayDisplay($aArrayUnique)

				_FileWriteFromArray($filea, $aArrayUnique, 2)

				TrayTip("整理完毕", "原文件:" & $aArray[0] & "行" & @CRLF & "新文件:" & $aArrayUnique[0] - 1 & "行", 10, 1)


;~ 				ttt()
			EndIf
		EndIf
;~ 	FileClose($filea)
	EndIf
	TraySetState(8)
	TraySetIcon("")
EndFunc   ;==>zhengli




Func openfile()
	TraySetIcon(@ScriptName, -6)
	TraySetState(4)
	TrayItemSetState($idAbout, $TRAY_DISABLE)
	TrayItemSetState($idopentxt, $TRAY_DISABLE)
	TrayItemSetState($idzhengli, $TRAY_DISABLE)
	TrayItemSetState($idcuttxt, $TRAY_DISABLE)
	TrayItemSetState($idpause, $TRAY_DISABLE)
	TrayItemSetState($idExit, $TRAY_DISABLE)
	$pid = ShellExecute($clfile)


	Do
		Sleep(10)

	Until Not ProcessExists($pid)
	ClipPut("")
	TraySetState(8)
	$tttt = 1
;~ 	ttt()
	TraySetIcon("")

	TrayItemSetState($idpause, $TRAY_enABLE)
	TrayItemSetState($idAbout, $tray_enable)
	TrayItemSetState($idopentxt, $tray_enable)
	TrayItemSetState($idzhengli, $tray_enable)
	TrayItemSetState($idcuttxt, $tray_enable)

	TrayItemSetState($idExit, $tray_enable)
EndFunc   ;==>openfile




Func ttt()

If $beep=1 Then
	$beep=0
	TrayItemSetState($idAbout,$TRAY_CHECKED)
Else
	$beep=1
	TrayItemSetState($idAbout,$TRAY_UNCHECKED)
EndIf

EndFunc   ;==>ttt


;~ https://btsow.pw/magnet/detail/hash/1EE472CBDE8DE0E3A17867752F19EB830FE62339


Func main()
;~ 	Sleep(110)
	ClipGet()
	If Not @error Then
;~ 		MsgBox(0,0,$stext)

$http=StringRegExp(ClipGet(),"http.+?hash\=([a-zA-Z0-9]{43})",3)
$tzm=StringRegExp(ClipGet(),".*([a-fA-F0-9]{40})\R",3)
$tzm2=StringRegExp(ClipGet(),".*([a-zA-Z2-7]{32})\R",3)
$btso=stringregexp(ClipGet(),"https://btsow.pw/magnet/detail/hash/([a-fA-F0-9]{40})",3)
$mag=StringRegExp(ClipGet(),"(magnet\:\?xt\=urn\:btih\:[a-fA-F0-9]{40})",3)
$mag2=StringRegExp(ClipGet(),"(magnet\:\?xt\=urn\:btih\:[a-zA-Z2-7]{32})",3)
$ed2k=StringRegExp(ClipGet(),"(ed2k\:\/\/\|file\|[^\|]+?\|\d+?\|[0-9a-zA-Z]{32}\|.+?\|\/)",3)
;~ $all=StringRegExp($stext,"[(ed2k\:\/\/\|file\|[^\|]+?\|\d+?\|[0-9a-zA-Z]{32}\|.+?\|\/),(magnet\:\?xt\=urn\:btih\:[a-zA-Z0-9]{40})]",3)

;"ed2k://|file|<file name>|<file size>|<file hash>|/
;这是最基本的eD2k链接格式，仅包含了必需的文件描述信息比如：文件名，文件大小和文件hash值"
;~ _ArrayDisplay($http,"http")
;~ _ArrayDisplay($mag,"mag")
;~ _ArrayDisplay($ed2k,"ed2k")
;~ _ArrayDisplay($tzm,"tzm")
;~ _ArrayDisplay($btso,"btso")
If IsArray($http) Then
For $i=0 To UBound($http)-1
$http[$i]="magnet:?xt=urn:btih:"&StringTrimleft($http[$i],3)
Next
EndIf
If IsArray($tzm) Then
For $i=0 To UBound($tzm)-1
$tzm[$i]="magnet:?xt=urn:btih:"&$tzm[$i]
Next
EndIf
If IsArray($tzm2) Then
For $i=0 To UBound($tzm2)-1
$tzm2[$i]="magnet:?xt=urn:btih:"&$tzm2[$i]
Next
EndIf
If IsArray($btso) Then
For $i=0 To UBound($btso)-1
$btso[$i]="magnet:?xt=urn:btih:"&$btso[$i]
Next
EndIf
;~ _ArrayDisplay($http)
;~ _ArrayDisplay($tzm)
Local $new[0]
If IsArray($http) Then
	_ArrayConcatenate($new,$http)
;~ 	_ArrayDisplay($new)
EndIf
If IsArray($tzm) Then
	_ArrayConcatenate($new,$tzm)
;~ 	_ArrayDisplay($new)
EndIf
If IsArray($tzm2) Then
	_ArrayConcatenate($new,$tzm2)
;~ 	_ArrayDisplay($new)
EndIf
If IsArray($btso) Then
	_ArrayConcatenate($new,$btso)
;~ 	_ArrayDisplay($new)
EndIf
If IsArray($mag) Then
	_ArrayConcatenate($new,$mag)
;~ 	_ArrayDisplay($new)
EndIf
If IsArray($mag2) Then
	_ArrayConcatenate($new,$mag2)
;~ 	_ArrayDisplay($new)
EndIf

If IsArray($ed2k) Then
	_ArrayConcatenate($new,$ed2k)
;~ 	_ArrayDisplay($new)
EndIf

;~ If UBound($new)>0  Then _ArrayDisplay($new)
$neww=_ArrayUnique($new,0,0,0,0)
If UBound($neww)>0  Then
;~ 	_ArrayDisplay($neww)
TrayTip("捕获到 "&UBound($neww)&" 个磁力链接"," ",5,1)
$sfile=FileOpen($clfile,1+8)
_FileWriteFromArray($sfile, $neww)
FileClose($sfile)
;~ $stext=""
ClipPut("")
EndIf
EndIf

EndFunc   ;==>main








;~ _ArrayDisplay($newa)

;~ MsgBox(0,"1",$txt)

;~ _ArrayDisplay($txtarray)
