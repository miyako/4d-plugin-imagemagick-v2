//%attributes = {}
$error:=IM Get Format List ($formats)

For ($i;1;Size of array:C274($formats))
	$format:=$formats{$i}
	ARRAY LONGINT:C221($pos;0)
	ARRAY LONGINT:C221($len;0)
	If (Match regex:C1019("(\\S+)\\s+\\((.+)\\)\\s+(\\S+)";$format;1;$pos;$len)
		$formats{$i}:="|"+Substring:C12($format;$pos{1};$len{1})+"|"+Substring:C12($format;$pos{2};$len{2})+"|"+Substring:C12($format;$pos{3};$len{3})+"|"
	End if 
End for 

$col:=New collection:C1472

ARRAY TO COLLECTION:C1563($col;$formats)

SET TEXT TO PASTEBOARD:C523("|Format|Description|Mode|\r|:-:|-|-|\r"+$col.join("\r"))