//%attributes = {}
$im:=IM New Object 

$path:=System folder:C487(Desktop:K41:16)+"IPSJ-Z75-3Z-9.pdf[1]"  //open page 2

$error:=IM Open File ($im;$path)  //open in default dpi
$error:=IM Set Image Properties ($im;IM_Pref_Density;"";300;300)
$error:=IM Open File ($im;$path)  //open again to apply new dpi

$error:=IM Set Image Properties ($im;IM_Pref_Magick;"PNG")  //convert to .png

$error:=IM Save Blob ($im;$PNG)

$error:=IM Clear Object ($im)

BLOB TO DOCUMENT:C526(System folder:C487(Desktop:K41:16)+"test.png";$PNG)