![version](https://img.shields.io/badge/version-17%2B-3E8B93)
![platform](https://img.shields.io/static/v1?label=platform&message=mac-intel%20|%20mac-arm%20|%20win-64&color=blue)
[![license](https://img.shields.io/github/license/miyako/4d-plugin-imagemagick-v2)](LICENSE)
![downloads](https://img.shields.io/github/downloads/miyako/4d-plugin-imagemagick-v2/total)

# 4d-plugin-imagemagick-v2

Updated version of [Tech Note: ImageMagick Plug-in](http://kb.4d.com/assetid=43892) by Thomas Maul.

The plugin links [ImageMagick 7](https://imagemagick.org) (Magick++) and lets 4D read, convert, transform, draw on and write images in the formats ImageMagick supports, including PICT, PDF and PostScript (through the bundled Ghostscript), TIFF, PNG, JPEG, JPEG 2000, WebP and OpenEXR. You work with numbered **image objects**: create one with [IM New Object](#im-new-object), load an image from a file or a `BLOB`, change it, save it to a file or a `BLOB`, then free it with [IM Clear Object](#im-clear-object). Every command except [IM Get Last Error](#im-get-last-error) returns a `Longint` status code.

| Command | Returns | Purpose |
|---|---|---|
| [IM New Object](#im-new-object) | `Longint` | Create an empty image object and return its number |
| [IM Clear Object](#im-clear-object) | `Longint` | Free an image object |
| [IM Copy](#im-copy) | `Longint` | Copy the image of one object into another |
| [IM Create](#im-create) | `Longint` | Create a blank image of a given size and color |
| [IM Open File](#im-open-file) | `Longint` | Read an image file |
| [IM Save File](#im-save-file) | `Longint` | Write the image to a file |
| [IM Open Blob](#im-open-blob) | `Longint` | Read an image from a `BLOB` |
| [IM Save Blob](#im-save-blob) | `Longint` | Write the image to a `BLOB` |
| [IM Get Image Properties](#im-get-image-properties) | `Longint` | Read a property (size, format, density, colors, …) |
| [IM Set Image Properties](#im-set-image-properties) | `Longint` | Change a property (format, quality, density, colors, …) |
| [IM Modify Image](#im-modify-image) | `Longint` | Apply a transformation or filter (crop, rotate, scale, blur, …) |
| [IM Draw](#im-draw) | `Longint` | Draw a shape, text or another image onto the image |
| [IM Get Last Error](#im-get-last-error) | `Text` | Get the last ImageMagick error message of an object |
| [IM Get Format List](#im-get-format-list) | `Longint` | List the formats ImageMagick can read |

**Platforms:** macOS (Apple silicon and Intel, universal binary, macOS 11.5 or later) and Windows (64-bit). 4D v17 or later.

---

## Requirements & platform notes

- **Status codes.** All commands except [IM Get Last Error](#im-get-last-error) return one of these values:

  | Value | Meaning |
  |---|---|
  | `0` | Success (also returned when ImageMagick only issued a warning while reading, see [IM Get Last Error](#im-get-last-error)) |
  | `-1` | Unknown image object: the number was never returned by [IM New Object](#im-new-object), or the object was already cleared |
  | `-2` | ImageMagick raised an error; call [IM Get Last Error](#im-get-last-error) for the message |
  | `-3` | The object holds no image yet: open, create or copy one first |
  | `-4` | Unknown property, operation or shape selector |

- **Most commands need a loaded image.** [IM Save File](#im-save-file), [IM Save Blob](#im-save-blob), [IM Get Image Properties](#im-get-image-properties), [IM Set Image Properties](#im-set-image-properties), [IM Modify Image](#im-modify-image) and [IM Draw](#im-draw) return `-3` until the object holds an image (from [IM Open File](#im-open-file), [IM Open Blob](#im-open-blob), [IM Create](#im-create) or [IM Copy](#im-copy)). That includes settings you'd want to apply *before* reading, such as the density: open the file once, set the property, then open it again (see [IM Open File](#im-open-file)).
- **File paths on macOS are HFS paths** (`Macintosh HD:Users:…`, as returned by `System folder` or `File.platformPath`). The plugin converts them to POSIX paths before passing them to ImageMagick. On Windows, pass a normal Windows path.
- **Image objects are process-wide.** Object numbers are shared by all processes, and they are reused: after [IM Clear Object](#im-clear-object) on object `3`, the next [IM New Object](#im-new-object) can return `3` again. An object lives until you clear it or 4D quits, and keeps its image in memory until then.
- **Thread safety.** All commands are declared thread-safe, so they can run in preemptive processes. Don't use the **same** image object from two processes at the same time, and don't clear an object while another process is using it: the plugin doesn't lock individual objects.
- **PDF, PostScript and EPS** are read through the Ghostscript library bundled in the plugin (`libgs` on macOS, `gsdll64.dll` on Windows). The plugin sets `MAGICK_GHOSTSCRIPT_PATH` to its own folder at startup.
- **The supported formats differ per platform**: the Apple silicon, Intel and Windows builds link different ImageMagick versions and delegate libraries. See [formats-apple.md](formats-apple.md), [formats-intel.md](formats-intel.md) and [formats-windows.md](formats-windows.md), or call [IM Get Format List](#im-get-format-list) at runtime.
- **Untrusted images.** The plugin sets no ImageMagick resource limits and no security policy. A very large or crafted image can use a lot of memory and disk and take a long time, and some formats (vector, script and text formats, PostScript/PDF through Ghostscript 9.21) can read other local files. Only open images you trust, or check their origin and type before passing them to the plugin.

---

## IM New Object

### Syntax

```
IM New Object → Longint
```

| Parameter | Type | Description |
|---|---|---|
| Result | `Longint` | Number of the new, empty image object (1 or more) |

### Description

Creates an empty image object and returns its number, the smallest one not in use. Pass it to every other command, and free the object with [IM Clear Object](#im-clear-object) when you are done.

The new object holds no image: most commands return `-3` until you call [IM Open File](#im-open-file), [IM Open Blob](#im-open-blob), [IM Create](#im-create) or [IM Copy](#im-copy).

### Example

From the plugin's own test method (`TEST_convert_png_to_pdf.4dm`):

```4d
//convert png to pdf

$im:=IM New Object

$file:=File:C1566("/RESOURCES/sample.png")

ASSERT:C1129($file.exists)

$error:=IM Open File($im; $file.platformPath)
$error:=IM Save File($im; System folder:C487(Desktop:K41:16)+"test.pdf")
$error:=IM Clear Object($im)
```

---

## IM Clear Object

### Syntax

```
IM Clear Object ( object ) → Longint
```

| Parameter | Type | Description |
|---|---|---|
| `object` | `Longint` | Image object number |
| Result | `Longint` | `0`, or `-1` if the object doesn't exist |

### Description

Frees the image object and its image. The number becomes invalid and can be returned again by a later [IM New Object](#im-new-object).

### Example

```4d
$im:=IM New Object
// ... work with $im ...
$error:=IM Clear Object($im)
```

---

## IM Copy

### Syntax

```
IM Copy ( destination ; source ) → Longint
```

| Parameter | Type | Description |
|---|---|---|
| `destination` | `Longint` | Image object that receives the copy |
| `source` | `Longint` | Image object to copy |
| Result | `Longint` | `0`, or `-1` if either object doesn't exist |

### Description

Replaces the image of `destination` with the image of `source`, including its settings (format, quality, colors, …). The **destination comes first**. Afterwards the two objects are independent: changing one doesn't change the other. If `source` holds no image, `destination` ends up holding none either.

The last error message of `destination` is kept, not copied from `source`. (Before this release's modernization the command also copied the error text in a way that could crash 4D when both objects were later cleared.)

### Example

```4d
// keep the original, work on a copy
$original:=IM New Object
$error:=IM Open File($original; $path)

$thumb:=IM New Object
$error:=IM Copy($thumb; $original)
$error:=IM Modify Image($thumb; IM_Scale; ""; 200; 200)
$error:=IM Save File($thumb; $thumbPath)

$error:=IM Clear Object($thumb)
$error:=IM Clear Object($original)
```

---

## IM Create

### Syntax

```
IM Create ( object ; width ; height ; color ) → Longint
```

| Parameter | Type | Description |
|---|---|---|
| `object` | `Longint` | Image object number |
| `width` | `Longint` | Width in pixels |
| `height` | `Longint` | Height in pixels |
| `color` | `Text` | Fill color, e.g. `"#FFFFFF"` or `"rgb(255,0,0)"` (see below about color names) |
| Result | `Longint` | `0`, `-1`, or `-2` (invalid color or size, see [IM Get Last Error](#im-get-last-error)) |

### Description

Replaces the image of `object` with a new image of `width` × `height` pixels filled with `color`. The format of the new image is `XC` (ImageMagick's constant-color pseudo-format), so set a real format with `IM_Pref_Magick` before [IM Save Blob](#im-save-blob); [IM Save File](#im-save-file) takes the format from the file extension.

A negative `width` or `height` is treated as `0`, which ImageMagick rejects with `-2` (behaviour after this review's fixes; before, a negative value wrapped to a huge size).

**Prefer hex colors.** ImageMagick's color-name table (`colors.xml`) is not bundled. In a test program linked against the same libraries, the first use of a color *name* such as `"white"` on Apple silicon raised the warning `UnableToOpenConfigureFile colors.xml`, which the plugin reports as `-2`; later calls worked. Hex (`"#RRGGBB"`) and `rgb(…)` colors don't need the table.

### Example

```4d
$im:=IM New Object
$error:=IM Create($im; 640; 480; "#FFFFFF")
$error:=IM Draw($im; IM_Draw_Rectangle; ""; 20; 20; 300; 200)
$error:=IM Save File($im; System folder:C487(Desktop:K41:16)+"canvas.png")
$error:=IM Clear Object($im)
```

---

## IM Open File

### Syntax

```
IM Open File ( object ; path ) → Longint
```

| Parameter | Type | Description |
|---|---|---|
| `object` | `Longint` | Image object number |
| `path` | `Text` | Path of the image file (HFS path on macOS). A zero-based page or frame index in brackets can follow, e.g. `"…:doc.pdf[1]"` for the second page |
| Result | `Longint` | `0`, `-1`, or `-2` (see [IM Get Last Error](#im-get-last-error)) |

### Description

Reads the file into the image object, replacing any image it held. ImageMagick detects the format from the file content and extension. For a multi-page document (PDF, multi-page TIFF, animated GIF) the object keeps one image: append `[n]` to the path to choose the page or frame.

If ImageMagick only issues a warning and still produces an image, the command returns `0` and the warning is available through [IM Get Last Error](#im-get-last-error).

Vector formats (PDF, PostScript, SVG) are rasterized at the object's density. To read them at a higher resolution, set `IM_Pref_Density` and open the file again, as in the first example.

### Example

From the plugin's own test method (`TEST_convert_from_pdf_file.4dm`):

```4d
$im:=IM New Object 

$path:=System folder:C487(Desktop:K41:16)+"IPSJ-Z75-3Z-9.pdf[1]"  //open page 2

$error:=IM Open File ($im;$path)  //open in default dpi
$error:=IM Set Image Properties ($im;IM_Pref_Density;"";300;300)
$error:=IM Open File ($im;$path)  //open again to apply new dpi

$error:=IM Set Image Properties ($im;IM_Pref_Magick;"PNG")  //convert to .png

$error:=IM Save Blob ($im;$PNG)

$error:=IM Clear Object ($im)

BLOB TO DOCUMENT:C526(System folder:C487(Desktop:K41:16)+"test.png";$PNG)
```

From `TEST_convert_from_pict.4dm`:

```4d
//  //convert pct to png

$im:=IM New Object

$file:=File:C1566("/RESOURCES/sample.pct")

ASSERT:C1129($file.exists)

$error:=IM Open File($im; $file.platformPath)
$error:=IM Save File($im; System folder:C487(Desktop:K41:16)+"test.png")
$error:=IM Clear Object($im)
```

---

## IM Save File

### Syntax

```
IM Save File ( object ; path ) → Longint
```

| Parameter | Type | Description |
|---|---|---|
| `object` | `Longint` | Image object number |
| `path` | `Text` | Destination path (HFS path on macOS) |
| Result | `Longint` | `0`, `-1`, `-2` (see [IM Get Last Error](#im-get-last-error)) or `-3` (no image) |

### Description

Writes the image to `path`. ImageMagick chooses the output format from the file extension (`.png`, `.pdf`, `.tif`, …); without a recognised extension it uses the object's current format (`IM_Pref_Magick`).

### Example

From the plugin's own test method (`TEST_convert_jpg_to_pdf.4dm`):

```4d
//convert jpg to pdf

$im:=IM New Object

$file:=File:C1566("/RESOURCES/sample.jpg")

ASSERT:C1129($file.exists)

$error:=IM Open File($im; $file.platformPath)
$error:=IM Save File($im; System folder:C487(Desktop:K41:16)+"test.pdf")
$error:=IM Clear Object($im)
```

---

## IM Open Blob

### Syntax

```
IM Open Blob ( object ; data ) → Longint
```

| Parameter | Type | Description |
|---|---|---|
| `object` | `Longint` | Image object number |
| `data` | `BLOB` | Encoded image (the bytes of a PNG, JPEG, PDF, … file) |
| Result | `Longint` | `0`, `-1`, or `-2` (see [IM Get Last Error](#im-get-last-error)) |

### Description

Reads an image from the content of a `BLOB`, replacing any image the object held. The format is detected from the data. The plugin copies the data, so you can change or clear the `BLOB` afterwards.

An **empty** `BLOB` returns `0` without reading anything: the object keeps its previous image (or none). Check the size of the `BLOB` before the call.

### Example

From the plugin's own test method (`TEST_convert_from_pdf.4dm`):

```4d
$im:=IM New Object

$file:=File:C1566("/RESOURCES/sample.pdf")

ASSERT:C1129($file.exists)

DOCUMENT TO BLOB:C525($file.platformPath; $PDF)

$error:=IM Open Blob($im; $PDF)

$error:=IM Set Image Properties($im; 13; "PNG")
$error:=IM Save Blob($im; $PNG)

$error:=IM Clear Object($im)

BLOB TO DOCUMENT:C526(System folder:C487(Desktop:K41:16)+"test.png"; $PNG)
```

`13` in this test is `IM_Pref_Compression`, not `IM_Pref_Magick` (`4`), so the result is not converted to PNG. To convert, use `IM_Pref_Magick`:

```4d
$error:=IM Open Blob($im; $PDF)
$error:=IM Set Image Properties($im; IM_Pref_Magick; "PNG")
$error:=IM Save Blob($im; $PNG)
```

---

## IM Save Blob

### Syntax

```
IM Save Blob ( object ; data ) → Longint
```

| Parameter | Type | Description |
|---|---|---|
| `object` | `Longint` | Image object number |
| `data` | `BLOB` | Receives the encoded image |
| Result | `Longint` | `0`, `-1`, `-2` (see [IM Get Last Error](#im-get-last-error)) or `-3` (no image) |

### Description

Encodes the image in the object's current format and stores the bytes in `data`, replacing its content. The current format is the one the image was read in, unless you changed it with `IM_Pref_Magick` in [IM Set Image Properties](#im-set-image-properties). After [IM Create](#im-create) the format is `XC`, so set one before saving.

### Example

```4d
$im:=IM New Object
$error:=IM Open File($im; $path)
$error:=IM Set Image Properties($im; IM_Pref_Magick; "JPEG")
$error:=IM Set Image Properties($im; IM_Pref_Quality; ""; 85)
$error:=IM Save Blob($im; $jpeg)
$error:=IM Clear Object($im)
```

---

## IM Get Image Properties

### Syntax

```
IM Get Image Properties ( object ; property ; text ; value1 ; value2 ; value3 ; value4 ) → Longint
```

| Parameter | Type | Description |
|---|---|---|
| `object` | `Longint` | Image object number |
| `property` | `Longint` | Property to read, see the table below |
| `text` | `Text` | Receives text properties (format, colors) |
| `value1` … `value4` | `Real` | Receive numeric properties |
| Result | `Longint` | `0`, `-1`, `-2`, `-3` (no image) or `-4` (unknown property) |

### Description

Reads one property of the image. All output parameters are written back on every call: `text` is `""` and unused values are `0` when the property doesn't use them or when the command fails. Trailing parameters you don't need can be left out, as the test methods do.

| `property` | Constant | `text` | `value1` | `value2` | `value3` | `value4` |
|---|---|---|---|---|---|---|
| 1 | `IM_Pref_Quality` | | compression quality (`0` if unset) | | | |
| 2 | `IM_Pref_Size` | | original width | original height | | |
| 3 | `IM_Pref_Geometry` | | current width | current height | horizontal resolution | vertical resolution |
| 4 | `IM_Pref_Magick` | format, e.g. `"PNG"` | | | | |
| 5 | `IM_Pref_Attribute` | always `""` (see below) | | | | |
| 6 | `IM_Pref_BackgroundColor` | color | | | | |
| 7 | `IM_Pref_BorderColor` | color | | | | |
| 8 | `IM_Pref_BoxColor` | color | | | | |
| 9 | `IM_Pref_StrokeColor` | color | | | | |
| 10 | `IM_Pref_FillColor` | color | | | | |
| 11 | `IM_Pref_StrokeWidht` | | stroke width | | | |
| 12 | `IM_Pref_Density` | | horizontal density | vertical density | | |
| 13 | `IM_Pref_Compression` | | compression type (ImageMagick number, see [IM Set Image Properties](#im-set-image-properties)) | | | |

The constant for 11 is spelled `IM_Pref_StrokeWidht` in the plugin's constant list.

Colors come back in ImageMagick's 16-bit hex notation, e.g. `"#FFFFFFFFFFFF"` for white.

**`IM_Pref_Attribute` doesn't work for reading:** the command never reads the attribute name from `text`, so it always looks up an empty name and returns `""`.

### Example

```4d
C_REAL($width; $height; $xres; $yres)
C_TEXT($format)

$error:=IM Get Image Properties($im; IM_Pref_Geometry; ""; $width; $height; $xres; $yres)
$error:=IM Get Image Properties($im; IM_Pref_Magick; $format)
```

From `TEST_load_pdf.4dm`:

```4d
$error:=IM Get Image Properties($im; IM_Pref_Compression; ""; $compression)
```

---

## IM Set Image Properties

### Syntax

```
IM Set Image Properties ( object ; property ; text ; value1 ; value2 ; value3 ; value4 ) → Longint
```

| Parameter | Type | Description |
|---|---|---|
| `object` | `Longint` | Image object number |
| `property` | `Longint` | Property to change, see the table below |
| `text` | `Text` | New value of text properties; ignored for the others |
| `value1` … `value4` | `Real` | New value of numeric properties; ignored for the others |
| Result | `Longint` | `0`, `-1`, `-2`, `-3` (no image) or `-4` (unknown or read-only property) |

### Description

Changes one property of the image. The object must already hold an image (`-3` otherwise).

| `property` | Constant | Parameters |
|---|---|---|
| 1 | `IM_Pref_Quality` | `value1`: compression quality, e.g. 0–100 for JPEG |
| 2 | `IM_Pref_Size` | read-only: returns `-4` |
| 3 | `IM_Pref_Geometry` | read-only: returns `-4` (resize with [IM Modify Image](#im-modify-image)) |
| 4 | `IM_Pref_Magick` | `text`: output format for [IM Save Blob](#im-save-blob), e.g. `"PNG"`, `"JPEG"`, `"PDF"` |
| 5 | `IM_Pref_Attribute` | `text`: name, a tab, then the value; without a tab nothing is changed and `0` is returned |
| 6 | `IM_Pref_BackgroundColor` | `text`: color |
| 7 | `IM_Pref_BorderColor` | `text`: color |
| 8 | `IM_Pref_BoxColor` | `text`: color |
| 9 | `IM_Pref_StrokeColor` | `text`: outline color used by [IM Draw](#im-draw) |
| 10 | `IM_Pref_FillColor` | `text`: fill color used by [IM Draw](#im-draw) |
| 11 | `IM_Pref_StrokeWidht` | `value1`: outline width used by [IM Draw](#im-draw) |
| 12 | `IM_Pref_Density` | `value1`, `value2`: horizontal and vertical density (dpi). Applies to the **next** read of a vector format |
| 13 | `IM_Pref_Compression` | `value1`: ImageMagick compression number (table below) |

**The `IM_Compression_…` constants don't match ImageMagick's numbering.** Most of them are off by one: `IM_Compression_LZMA` (15) selects LZW, `IM_Compression_JPEG` (13) selects lossless JPEG, and so on. Pass the number ImageMagick expects instead:

| Value | Compression | Value | Compression |
|---|---|---|---|
| 1 | B44A | 14 | LZMA |
| 2 | B44 | 15 | LZW |
| 3 | BZip | 16 | None |
| 4 | DXT1 | 17 | Piz |
| 5 | DXT3 | 18 | Pxr24 |
| 6 | DXT5 | 19 | RLE |
| 7 | Fax | 20 | Zip |
| 8 | Group4 | 21 | ZipS |
| 9 | JBIG1 | 22 | Zstd |
| 10 | JBIG2 | 23 | WebP |
| 11 | JPEG2000 | 24 | DWAA |
| 12 | JPEG | 25 | DWAB |
| 13 | LosslessJPEG | | |

These values come from the ImageMagick 7.0.10 headers in this repository. Which ones an output format accepts depends on the format.

### Example

From the plugin's own test method (`TEST_load_pdf.4dm`; despite its name, it opens a TIFF):

```4d
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
```

Because of the numbering issue above, `IM_Compression_LZMA` here requests LZW compression; pass `14` for LZMA.

Setting a comment attribute:

```4d
$error:=IM Set Image Properties($im; IM_Pref_Attribute; "comment"+Char(Tab)+"Scanned by 4D")
```

---

## IM Modify Image

### Syntax

```
IM Modify Image ( object ; operation ; text ; value1 ; value2 ; value3 ; value4 ; value5 ; value6 ) → Longint
```

| Parameter | Type | Description |
|---|---|---|
| `object` | `Longint` | Image object number |
| `operation` | `Longint` | Operation, see the table below |
| `text` | `Text` | Not used by any operation; pass `""` |
| `value1` … `value6` | `Real` | Operation arguments; unused ones are ignored |
| Result | `Longint` | `0`, `-1`, `-2`, `-3` (no image) or `-4` (unknown operation) |

### Description

Applies an ImageMagick transformation to the image in place. The arguments go to the Magick++ method of the same name; see the ImageMagick documentation of that method for the exact effect of each value. Sizes and offsets are in pixels. Negative, NaN or out-of-range values for sizes are treated as `0` (behaviour after this review's fixes).

| `operation` | Constant | Arguments |
|---|---|---|
| 1 | `IM_AddNoise` | `value1`: noise type: 1 uniform, 2 gaussian, 3 multiplicative gaussian, 4 impulse, 5 laplacian, 6 poisson, 7 random |
| 2 | `IM_Flip` | none (vertical mirror) |
| 3 | `IM_Flop` | none (horizontal mirror) |
| 4 | `IM_Implode` | `value1`: amount |
| 5 | `IM_Rotate` | `value1`: degrees |
| 6 | `IM_Crop` | `value1`, `value2`: top-left x, y; `value3`, `value4`: bottom-right x, y |
| 7 | `IM_Blur` | `value1`: radius; `value2`: sigma (`0` = ImageMagick default) |
| 8 | `IM_Contrast` | `value1`: non-zero to increase contrast, `0` to reduce it |
| 9 | `IM_Despeckle` | none |
| 10 | `IM_AdaptiveThreshold` | `value1`: width; `value2`: height; `value3`: bias |
| 11 | `IM_Unused` | not implemented: returns `-4` |
| 12 | `IM_Zoom` | `value1`: width; `value2`: height |
| 13 | `IM_Edge` | `value1`: radius |
| 14 | `IM_Emboss` | `value1`: radius; `value2`: sigma |
| 15 | `IM_Enhance` | none |
| 16 | `IM_Equalize` | none |
| 17 | `IM_Frame` | `value1`: width; `value2`: height; `value3`: inner bevel; `value4`: outer bevel |
| 18 | `IM_Gamma` | `value1`: gamma; if `0`, `value2`, `value3`, `value4` are the red, green, blue gamma |
| 19 | `iM_GaussianBlur` | `value1`: radius; `value2`: sigma |
| 20 | `IM_Level` | `value1`: black point; `value2`: white point; `value3`: gamma (see below) |
| 21 | `IM_Magnify` | none (double the size) |
| 22 | `IM_Minify` | none (halve the size) |
| 23 | `IM_MedianFilter` | `value1`: radius |
| 24 | `IM_Modulate` | `value1`: brightness; `value2`: saturation; `value3`: hue (percent, `100` = unchanged) |
| 25 | `IM_Negate` | `value1`: non-zero to negate only grayscale pixels |
| 26 | `IM_Normalize` | none |
| 27 | `IM_OilPaint` | `value1`: radius |
| 28 | `IM_Raise` | `value1`: width; `value2`: height; `value3`: x; `value4`: y; `value5`: non-zero for raised, `0` for sunken |
| 29 | `IM_ReduceNoise` | `value1`: order (`0` = ImageMagick default) |
| 30 | `IM_Roll` | `value1`: columns; `value2`: rows |
| 31 | `IM_Sample` | `value1`: width; `value2`: height |
| 32 | `IM_Scale` | `value1`: width; `value2`: height |
| 33 | `IM_Segment` | `value1`: cluster threshold; `value2`: smoothing threshold |
| 34 | `IM_Shade` | `value1`: azimuth; `value2`: elevation; `value3`: non-zero for color shading |
| 35 | `IM_Sharpen` | `value1`: radius; `value2`: sigma |
| 36 | `IM_Shave` | `value1`: width; `value2`: height to remove from each edge |
| 37 | `IM_Shear` | `value1`: x degrees; `value2`: y degrees |
| 38 | `IM_Solarize` | `value1`: factor |
| 39 | `IM_Spread` | `value1`: amount (truncated to an integer) |
| 40 | `IM_Swirl` | `value1`: degrees |
| 41 | `IM_Threshold` | `value1`: threshold |
| 42 | `IM_Trim` | none |
| 43 | `IM_Unsharpmask` | `value1`: radius; `value2`: sigma; `value3`: amount; `value4`: threshold |
| 44 | `IM_Wave` | `value1`: amplitude; `value2`: wavelength |

The Gaussian blur constant is spelled `iM_GaussianBlur` in the plugin's constant list.

`IM_Zoom`, `IM_Sample` and `IM_Scale` fit the image into `value1` × `value2` and keep the aspect ratio (ImageMagick geometry rules).

**`IM_Level`** computes the black and white points from the image's quantize-colors setting (`value / 100 × colors`), not from the full intensity range, so the result doesn't match ImageMagick's `-level` percentages. Test it on your images before relying on it.

### Example

```4d
$im:=IM New Object
$error:=IM Open File($im; $path)
$error:=IM Modify Image($im; IM_Crop; ""; 100; 100; 500; 400)  // keep (100,100)-(500,400)
$error:=IM Modify Image($im; IM_Rotate; ""; 90)
$error:=IM Modify Image($im; IM_Scale; ""; 200; 200)
$error:=IM Save File($im; $outPath)
$error:=IM Clear Object($im)
```

---

## IM Draw

### Syntax

```
IM Draw ( object ; shape ; text ; value1 ; value2 ; value3 ; value4 ; value5 ; value6 ) → Longint
```

| Parameter | Type | Description |
|---|---|---|
| `object` | `Longint` | Image object number |
| `shape` | `Longint` | What to draw, see the table below |
| `text` | `Text` | The string for shape `11`, or an image file path for `IM_Draw_Composite`; otherwise ignored |
| `value1` … `value6` | `Real` | Shape arguments |
| Result | `Longint` | `0`, `-1` (also: unknown composite object), `-2`, `-3` (no image) or `-4` (unknown shape) |

### Description

Draws onto the image. Shapes use the stroke color, stroke width and fill color set with [IM Set Image Properties](#im-set-image-properties) (`IM_Pref_StrokeColor`, `IM_Pref_StrokeWidht`, `IM_Pref_FillColor`). Coordinates are in pixels from the top-left corner.

| `shape` | Constant | Arguments |
|---|---|---|
| 1 | `IM_Draw_Circle` | `value1`, `value2`: center x, y; `value3`, `value4`: a point on the circle |
| 2 | `IM_Draw_Rectangle` | `value1`, `value2`: top-left x, y; `value3`, `value4`: bottom-right x, y |
| 3 | `IM_Draw_Arc` | `value1`…`value4`: bounding box (x1, y1, x2, y2); `value5`, `value6`: start and end angle in degrees |
| 4 | `IM_Draw_Color` | `value1`, `value2`: x, y; `value3`: paint method (see below) |
| 5 | `IM_Draw_Composite` | `value1`: image object to draw, or `0` to read the image from the path in `text`; `value2`, `value3`: x, y; `value4`, `value5`: width, height; `value6`: ImageMagick composite operator number |
| 6 | `IM_Draw_Ellipse` | `value1`, `value2`: center x, y; `value3`, `value4`: radius x, y; `value5`, `value6`: start and end angle in degrees |
| 7 | `IM_Draw_Line` | `value1`, `value2`: start x, y; `value3`, `value4`: end x, y |
| 8 | `IM_Draw_Matte` | `value1`, `value2`: x, y; `value3`: paint method; changes transparency |
| 9 | `IM_Draw_Point` | `value1`, `value2`: x, y |
| 10 | `IM_Draw_RoundRectangle` | `value1`…`value4`: top-left x, y and bottom-right x, y; `value5`, `value6`: corner width, height |
| 11 | (no constant) | text: `value1`, `value2`: x, y of the baseline start; `value3`: point size; `text`: the string |

**Composite operator.** `value6` of `IM_Draw_Composite` is ImageMagick's `CompositeOperator` number; in the ImageMagick 7.0.10 headers in this repository, `54` is "Over" (normal alpha blending) and `13` is "Copy". There are no plugin constants for them.

**Paint methods** (`IM_Draw_Color`, `IM_Draw_Matte`): ImageMagick numbers them 1 point, 2 replace, 3 flood fill, 4 fill to border, 5 reset. The `IM_Paint_…` constants are one lower (`IM_Paint_Point` is `0`, "undefined"), so pass the numbers instead of the constants.

**Drawing text (11) blackens the whole image.** Before drawing the string, the command calls ImageMagick's `colorize` with 100 % black on the image; in a test program linked against the same libraries this turned every pixel black. It also sets the font to `Arial` and the background color to white. Until this is changed, don't rely on shape `11`.

### Example

```4d
$im:=IM New Object
$error:=IM Create($im; 400; 300; "#FFFFFF")
$error:=IM Set Image Properties($im; IM_Pref_StrokeColor; "#FF0000")
$error:=IM Set Image Properties($im; IM_Pref_StrokeWidht; ""; 3)
$error:=IM Set Image Properties($im; IM_Pref_FillColor; "#FFFF00")
$error:=IM Draw($im; IM_Draw_Circle; ""; 200; 150; 260; 150)
$error:=IM Draw($im; IM_Draw_Line; ""; 0; 0; 400; 300)
$error:=IM Save File($im; System folder:C487(Desktop:K41:16)+"shapes.png")
$error:=IM Clear Object($im)
```

Placing a logo held in another object, scaled to 64 × 64 at (10, 10), with the "Over" operator:

```4d
$error:=IM Draw($im; IM_Draw_Composite; ""; $logo; 10; 10; 64; 64; 54)
```

---

## IM Get Last Error

### Syntax

```
IM Get Last Error ( object ) → Text
```

| Parameter | Type | Description |
|---|---|---|
| `object` | `Longint` | Image object number |
| Result | `Text` | Last ImageMagick error or warning message of this object, or `""` |

### Description

Returns the message of the last ImageMagick error (or warning) for this object. The message is **not cleared** by a later successful command: check the status code first, and read the message when it is `-2`, or when you want to see a warning after a `0` from [IM Open File](#im-open-file) or [IM Open Blob](#im-open-blob).

For an unknown object it returns `""`.

### Example

```4d
$error:=IM Open File($im; $path)
If ($error#0)
	ALERT:C41(IM Get Last Error($im))
End if 
```

---

## IM Get Format List

### Syntax

```
IM Get Format List ( formats ) → Longint
```

| Parameter | Type | Description |
|---|---|---|
| `formats` | `Text array` | Receives one entry per readable format |
| Result | `Longint` | Always `0` |

### Description

Fills `formats` with the formats ImageMagick can **read** on this machine. Each entry has the form `NAME (description) rwm`, where the last three characters are `r` (readable), `w` (writable) and `m` (multi-frame), or a space when the capability is missing.

The list depends on the platform and build (see the `formats-*.md` files). If ImageMagick fails to list its formats, the array comes back empty (behaviour after this review's fixes).

### Example

From the plugin's own test method (`TEST.4dm`), which turns the list into a Markdown table:

```4d
$error:=IM Get Format List($formats)

For ($i; 1; Size of array:C274($formats))
	$format:=$formats{$i}
	ARRAY LONGINT:C221($pos; 0)
	ARRAY LONGINT:C221($len; 0)
	If (Match regex:C1019("(\\S+)\\s+\\((.+)\\)\\s+(\\S+)"; $format; 1; $pos; $len))
		$formats{$i}:="|"+Substring:C12($format; $pos{1}; $len{1})+"|"+Substring:C12($format; $pos{2}; $len{2})+"|"+Substring:C12($format; $pos{3}; $len{3})+"|"
	End if 
End for 

$col:=New collection:C1472

ARRAY TO COLLECTION:C1563($col; $formats)

SET TEXT TO PASTEBOARD:C523("|Format|Description|Mode|\r|:-:|-|-|\r"+$col.join("\r"))
```

---

## Error handling & troubleshooting

- **`-3` right after [IM New Object](#im-new-object).** The object holds no image yet. Open, create or copy an image before setting properties, modifying, drawing or saving.
- **Density has no effect.** `IM_Pref_Density` can only be set on an object that already holds an image, and it applies to the next read. Open the file, set the density, then open it again.
- **[IM Save Blob](#im-save-blob) keeps the original format.** The `BLOB` is encoded in the current format; set `IM_Pref_Magick` first. After [IM Create](#im-create) the format is `XC`.
- **`-2` with "UnableToOpenConfigureFile colors.xml".** A color name was used and the color table isn't bundled. Use `"#RRGGBB"` colors.
- **Wrong compression.** The `IM_Compression_…` constants are shifted from ImageMagick's numbering; pass the numbers from the table in [IM Set Image Properties](#im-set-image-properties).
- **Paint method does nothing.** The `IM_Paint_…` constants are one lower than ImageMagick's values; pass `1` to `5`.
- **Text drawing turns the image black.** Shape `11` of [IM Draw](#im-draw) colorizes the whole image black before drawing.
- **`IM_Pref_Attribute` always reads `""`.** Reading attributes doesn't work; only setting them does.
- **Stale error message.** [IM Get Last Error](#im-get-last-error) keeps the last message until another error replaces it; rely on the status code.
- **Empty `BLOB` reads as success.** [IM Open Blob](#im-open-blob) returns `0` for an empty `BLOB` without loading anything.
- **Paths on macOS.** Pass HFS paths (`System folder`, `File.platformPath`); a POSIX path is misread.
- **Memory.** Every object keeps its image until [IM Clear Object](#im-clear-object); clear objects in error paths too. Very large images, or crafted files that claim huge dimensions, can use a lot of memory and disk because no resource limits are set.
- **Concurrent use.** Don't share one object between processes running at the same time, and don't clear an object another process is using.

---

## Quick reference

```4d
$im:=IM New Object
$error:=IM Open File($im; $path)  // or IM Open Blob($im; $blob)
$error:=IM Get Image Properties($im; IM_Pref_Geometry; ""; $w; $h)
$error:=IM Modify Image($im; IM_Scale; ""; 800; 600)
$error:=IM Set Image Properties($im; IM_Pref_Magick; "JPEG")
$error:=IM Set Image Properties($im; IM_Pref_Quality; ""; 85)
$error:=IM Save Blob($im; $jpeg)  // or IM Save File($im; $outPath)
If ($error#0)
	$message:=IM Get Last Error($im)
End if 
$error:=IM Clear Object($im)
```

---

## Building

Releases are built by the **Build & Release** workflow (`.github/workflows/release.yml`) from a `vX.Y.Z` tag; **Bump version** (`.github/workflows/bump-version.yml`) bumps `MARKETING_VERSION` and tags. The macOS libraries in `a/`, the Windows libraries in `lib/windows64/`, and the Ghostscript runtime in `test/Plugins/ImageMagick.bundle/Contents/MacOS/` and `Contents/Windows64/` are committed prebuilt. The notes below describe how the macOS libraries were made.

* macOS bottle from homebrew

  * `webp--1.2.1_1.arm64_big_sur` 
  * ~~`imagemagick--7.1.0-17.arm64_big_sur`~~
  * ~~`openexr--3.1.3.arm64_big_sur`~~
  * ~~`ghostscript--9.55.0.arm64_big_sur`~~ 
  * `openjpeg--2.4.0.arm64_big_sur`
  * `jpeg--9d.arm64_big_sur`
  * `libpng--1.6.37.arm64_big_sur`
  * `libxml2--2.9.12.arm64_big_sur`
  * `fontconfig--2.13.1.arm64_big_sur`
  * `freetype--2.11.0.arm64_big_sur`
  * `libtiff--4.3.0.arm64_big_sur`

**OpenEXR**: bottle is dynamic; compile from [source](https://github.com/AcademySoftwareFoundation/openexr/releases/tag/v2.5.6).

**GhostScript**: compile `9.21` from source. see [gs](https://github.com/miyako/4d-plugin-gs).

copy headers to *include/ghostscript/*

* `gdevdsp.h`
* `gserrors.h`
* `iapi.h`
* `ierrors.h`

copy library to *lib/*

* `libgs.9.21.dylib`
* `libgs.9.dylib`
* `libgs.dylib`

**TIFF**: use brew bottle and link manually

copy headers to *include/ghostscript/*

* `tiff.h`
* `tiffconf.h`
* `tiffio.h`
* `tiffio.hxx`
* `tiffvers.h`

copy library to *lib/*

* `libtiff.5.dylib`
* `libtiff.a`
* `libtiff.dylib`

**ImageMagick**: bottle is compiled with [`openmp`](https://mac.r-project.org/openmp/). it also links to [`liblqr`](https://github.com/carlobaldassi/liblqr) which links to `glib-2.0` which links to many other; compile from source.

* `--without-lqr`
* `--disable-openmp`

```sh
brew install freetype
brew install fontconfig
brew install openjpeg
brew install webp 
brew install openexr
./configure --without-lqr --disable-openmp --with-gslib --without-zstd --without-pango
```

~~gslib on Apple Silicon only works if plugin is compiled for Development (not Deployment)~~

#### Number of Formats

* [Apple](formats-apple.md): 235
* [Intel](formats-intel.md): 224
* [Windows](formats-windows.md): 218

#### Remarks

* CAL,CALS is `rw` on Intel, `r` on Apple
* APNG,WEBM,PHM is Apple only
