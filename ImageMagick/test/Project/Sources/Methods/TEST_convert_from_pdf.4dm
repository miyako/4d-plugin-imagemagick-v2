//%attributes = {"invisible":true}
$im:=IM New Object 

$file:=File:C1566("/RESOURCES/sample.pdf")

ASSERT:C1129($file.exists)

DOCUMENT TO BLOB:C525($file.platformPath;$PDF)

$error:=IM Open Blob ($im;$PDF)

$error:=IM Set Image Properties ($im;IM_Pref_Magick;"PNG")
$error:=IM Save Blob ($im;$PNG)

$error:=IM Clear Object ($im)

BLOB TO DOCUMENT:C526(System folder:C487(Desktop:K41:16)+"test.png";$PNG)
