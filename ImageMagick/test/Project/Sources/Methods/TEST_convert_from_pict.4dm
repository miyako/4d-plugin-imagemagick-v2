//%attributes = {}
//  //convert pct to png (OK) this works on 64-bit too!

$im:=IM New Object

$file:=File:C1566("/RESOURCES/sample.pct")

ASSERT:C1129($file.exists)

$error:=IM Open File($im; $file.platformPath)
$error:=IM Save File($im; System folder:C487(Desktop:K41:16)+"test.png")
$error:=IM Clear Object($im)
