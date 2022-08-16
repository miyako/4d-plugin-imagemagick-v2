//%attributes = {}
//convert png to jpeg

$im:=IM New Object

$file:=File:C1566("/RESOURCES/sample.png")

ASSERT:C1129($file.exists)

$error:=IM Open File($im; $file.platformPath)
$error:=IM Save File($im; System folder:C487(Desktop:K41:16)+"test.jpeg")
$error:=IM Clear Object($im)
