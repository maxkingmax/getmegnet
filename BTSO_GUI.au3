#Region ;**** 由 AccAu3Wrapper_GUI 创建指令 ****
#AccAu3Wrapper_Outfile_x64=BTSO_GUI_x64.exe
#AccAu3Wrapper_Res_Language=2052
#AccAu3Wrapper_Res_requestedExecutionLevel=None
#EndRegion ;**** 由 AccAu3Wrapper_GUI 创建指令 ****
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

#include <IE.au3>
#include <MsgBoxConstants.au3>
#include<array.au3>
#include<file.au3>
Opt("TrayMenuMode",0)

#Region ### START Koda GUI section ### Form=C:\Users\Administrator\Documents\Form1.kxf
$Form1 = GUICreate("btsow.pw 磁力链自动获取器", 613, 123, -1, -1, BitOR($GUI_SS_DEFAULT_GUI,$WS_MAXIMIZEBOX,$WS_SIZEBOX,$WS_THICKFRAME,$WS_TABSTOP), BitOR($WS_EX_TOOLWINDOW,$WS_EX_TOPMOST,$WS_EX_WINDOWEDGE))
$Label1 = GUICtrlCreateLabel("搜索关键词:", 16, 24, 83, 24)
GUICtrlSetFont(-1, 9, 400, 0, "微软雅黑")
$Input1 = GUICtrlCreateInput("", 104, 22, 249, 28)
GUICtrlSetFont(-1, 9, 400, 0, "微软雅黑")
$Combo1 = GUICtrlCreateCombo("", 464, 22, 81, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "0|500|1024|2048", "1024")
GUICtrlSetFont(-1, 9, 400, 0, "微软雅黑")
$Label2 = GUICtrlCreateLabel("文件大于:", 376, 24, 68, 24)
GUICtrlSetFont(-1, 9, 400, 0, "微软雅黑")
$Label3 = GUICtrlCreateLabel("MB", 554, 24, 28, 24)
GUICtrlSetFont(-1, 9, 400, 0, "微软雅黑")
$Button1 = GUICtrlCreateButton("开始", 234, 72, 145, 41)
GUICtrlSetFont(-1, 9, 400, 0, "微软雅黑")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $Button1
			Opt("TrayMenuMode",1)
			$ss=GUICtrlRead($Input1)
			If $ss="" Then 
				TrayTip("错误提示","请输入关键词",3,3)
;~ 				Sleep(5000)
				GUICtrlSetState ($Input1,256)
				GUICtrlSetTip($Input1,"请输入关键词","",3,1)
				ContinueCase
			EndIf
			
			$size=GUICtrlRead ($Combo1)
;~ 			If Not IsNumber ($size) Then
;~ 				TrayTip("错误提示","请输入数字量",3,3)
;~ 				Sleep(5000)
;~ 				GUICtrlSetState ($Combo1,256)
;~ 				GUICtrlSetTip($Combo1,"请输入数字量","",3,1)
;~ 				ContinueCase
;~ 			EndIf
			
			GUISetState(@SW_HIDE)
			Local $i=1
			Local $a=""
			Local $hTimer = TimerInit()
			do
				TraySetToolTip("正在打开网页并进行搜索...")
				Local $oIE = _IECreate("https://btsow.pw/search/"&$ss&"/page/"&$i,0,0)
				TraySetToolTip("正在处理第 "&$i&" 页...")
				Local $sHTML = _IEBodyReadHTML($oIE)
				$a&=$shtml
					consolewrite("第 "&$i&" 页"&@crlf)
					
				$i+=1
				$n=StringInStr($shtml,"Next")
				_IEQuit($oIE)
			until $n=0
			Local $fDiff = TimerDiff($hTimer)

			;~ msgbox(0,0,$a)
			TrayTip("搜索结果","共搜到 " &$i-1&" 个网页"&@CRLF&"耗时 "&int($fDiff/1000/60)&" 分 " &int(Mod ( $fDiff/1000, 60 ))&" 秒",5)
			sleep(2000)
			$b=stringregexp($a,"https://btsow.pw/magnet/detail/hash/([a-z,A-Z,0-9]{40})",3)
			;~ _arraydisplay($b)
			$c=stringregexp($a,"Size:(.+)B",3)
			;~ _arraydisplay($c)
			for $i=0 to UBound($c)-1
			   if stringinstr($c[$i],"G") Then
				  $c[$i]=StringTrimRight($c[$i],1)*1024
			   Else
				  $c[$i]=StringTrimRight($c[$i],1)
			   EndIf
			   Next
			;~    _ArrayDisplay($c)

			   for $i=0 to UBound($c)-1
				  if $c[$i]<$size Then
					 $b[$i]=""

				  EndIf
			   Next
			;~   _ArrayDisplay($b)
			  $b=_ArrayUnique($b,0,0,0,0)
			  for $i=0 to UBound($b)-1
				 if $b[$i]<>"" Then	 $b[$i]="magnet:?xt=urn:btih:" & $b[$i]
			  Next
			;~   _arraydisplay($b)

			_ArraySort($b,0)
			;~   _arraydisplay($b)
			  _ArrayDelete($b,0)
			;~   _arraydisplay($b)

			TrayTip("磁力链处理结果","共找到 " &UBound($b)-1&" 个磁力链接.",5)
			sleep(2000)
			  $f=fileopen("D:\CL_magnet.txt",1)
			  FileWriteLine($f,"<---------"&$ss&"---------")
			  _FileWriteFromArray($f,$b)
			   FileWriteLine($f,"---------"&$ss&"--------->")

			  FileClose($f)
			GUISetState(@SW_SHOW)
			TraySetToolTip("就绪")
			Opt("TrayMenuMode",1)
	EndSwitch
WEnd



