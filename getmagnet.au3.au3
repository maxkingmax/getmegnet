

#include<array.au3>
#include <IE.au3>
#include <MsgBoxConstants.au3>

;~ $url1="http://xn--9iqb42d81n.ml/htm_data/7/1802/2973273.html"
;~ $url2="http://xn--9iqb42d81n.ml/htm_data/2/1802/2976054.html"
;~ $url3="https://btso.pw/search/10musume"
;~ Local $oIE = _IECreate($url3)
;~ Local $sText = _IEBodyReadText($oIE)
;~ Local $stext = _iebodyreadhtml($oIE)
;~ MsgBox($MB_SYSTEMMODAL, "Body Text", $sText)
;~ FileWrite("1.txt",$sText)

$stext=""

;~ _IEQuit($oIE)
While 1
	If $stext="" Then 
		$stext=ClipGet()
;~ 		MsgBox(0,0,$stext)
Sleep(200)
$http=StringRegExp($stext,"http.+?hash\=([a-zA-Z0-9]{43})",3)
$tzm=StringRegExp($stext,".*([a-zA-Z0-9]{40})\R",3)
$btso=stringregexp($stext,"https://btso.pw/magnet/detail/hash/([a-z,A-Z,0-9]{40})",3)
$mag=StringRegExp($stext,"(magnet\:\?xt\=urn\:btih\:[a-zA-Z0-9]{40})",3)
$ed2k=StringRegExp($stext,"(ed2k\:\/\/\|file\|[^\|]+?\|\d+?\|[0-9a-zA-Z]{32}\|.+?\|\/)",3)
;~ $all=StringRegExp($stext,"[(ed2k\:\/\/\|file\|[^\|]+?\|\d+?\|[0-9a-zA-Z]{32}\|.+?\|\/),(magnet\:\?xt\=urn\:btih\:[a-zA-Z0-9]{40})]",3)

;"ed2k://|file|<file name>|<file size>|<file hash>|/
;这是最基本的eD2k链接格式，仅包含了必需的文件描述信息比如：文件名，文件大小和文件hash值"
_ArrayDisplay($http,"http")
_ArrayDisplay($mag,"mag")
_ArrayDisplay($ed2k,"ed2k")
_ArrayDisplay($tzm,"tzm")
_ArrayDisplay($btso,"btso")
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
If IsArray($btso) Then
	_ArrayConcatenate($new,$btso)
;~ 	_ArrayDisplay($new)
EndIf
If IsArray($mag) Then
	_ArrayConcatenate($new,$mag)
;~ 	_ArrayDisplay($new)
EndIf
If IsArray($ed2k) Then
	_ArrayConcatenate($new,$ed2k)
;~ 	_ArrayDisplay($new)
EndIf

If UBound($new)>0  Then _ArrayDisplay($new)
$neww=_ArrayUnique($new,0,0,0,0)
If UBound($neww)>0  Then 
	_ArrayDisplay($neww)

$stext=""
ClipPut("")
EndIf
EndIf
WEnd
