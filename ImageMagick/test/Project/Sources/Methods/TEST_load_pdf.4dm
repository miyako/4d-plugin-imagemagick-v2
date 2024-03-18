//%attributes = {"invisible":true}
$im:=IM New Object

$file:=File:C1566("/RESOURCES/smiley.pdf")
$file:=Folder:C1567(fk desktop folder:K87:19).file("4d-logo.tiff")

ASSERT:C1129($file.exists)

$error:=IM Open File($im; $file.platformPath)

$error:=IM Get Image Properties($im; IM_Pref_Compression; ""; $compression)
$error:=IM Set Image Properties($im; IM_Pref_Compression; ""; IM_Compression_LZMA)

$error:=IM Save File($im; System folder:C487(Desktop:K41:16)+"test.tiff")
//$error:=IM Save File($im; System folder(Desktop)+"test.pdf")
$error:=IM Clear Object($im)
