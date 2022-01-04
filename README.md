# 4d-plugin-imagemagick-v2

Updated version of [Tech Note: ImageMagick Plug-in](http://kb.4d.com/assetid=43892) by Thomas Maul.

Conversion to/from PICT or PDF is available, even on 64-bits!

* macOS bottle from homebrew

  * `webp--1.2.1_1.arm64_big_sur` 
  * `imagemagick--7.1.0-17.arm64_big_sur`
  * `openjpeg--2.4.0.arm64_big_sur`
  * `jpeg--9d.arm64_big_sur`
  * `libpng--1.6.37.arm64_big_sur`
  * `libxml2--2.9.12.arm64_big_sur`
  * `fontconfig--2.13.1.arm64_big_sur`
  * `freetype--2.11.0.arm64_big_sur`

OpenEXR bottle is dynamic; compile from [source](https://github.com/AcademySoftwareFoundation/openexr/releases/tag/v2.5.6)

brew bottle ImageMagick is compiled with [`openmp`](https://mac.r-project.org/openmp/).

it also links to `liblqr`

### Platform

| carbon | cocoa | win32 | win64 |
|:------:|:-----:|:---------:|:---------:|
||<img src="https://cloud.githubusercontent.com/assets/1725068/22371562/1b091f0a-e4db-11e6-8458-8653954a7cce.png" width="24" height="24" />|<img src="https://cloud.githubusercontent.com/assets/1725068/22371562/1b091f0a-e4db-11e6-8458-8653954a7cce.png" width="24" height="24" />|<img src="https://cloud.githubusercontent.com/assets/1725068/22371562/1b091f0a-e4db-11e6-8458-8653954a7cce.png" width="24" height="24" />|

### Version

<img width="32" height="32" src="https://user-images.githubusercontent.com/1725068/73986501-15964580-4981-11ea-9ac1-73c5cee50aae.png"> <img src="https://user-images.githubusercontent.com/1725068/73987971-db2ea780-4984-11ea-8ada-e25fb9c3cf4e.png" width="32" height="32" />

#### Configuration

* Windows

|Format|Description|Mode|
|:-:|-|-|
|3FR|Hasselblad CFV/H3D39II|r|
|3G2|Media Container|r|
|3GP|Media Container|r|
|A|Raw alpha samples|rwm|
|AAI|AAI Dune image|rwm|
|AI|Adobe Illustrator CS2|rw|
|ART|PFS: 1st Publisher Clip Art|rw|
|ARW|Sony Alpha Raw Image Format|r|
|AVI|Microsoft Audio/Visual Interleaved|r|
|AVS|AVS X image|rwm|
|B|Raw blue samples|rwm|
|BGR|Raw blue, green, and red samples|rwm|
|BGRA|Raw blue, green, red, and alpha samples|rwm|
|BGRO|Raw blue, green, red, and opacity samples|rwm|
|BMP|Microsoft Windows bitmap image|rw|
|C|Raw cyan samples|rwm|
|CAL|Continuous Acquisition and Life-cycle Support Type 1|rw|
|CALS|Continuous Acquisition and Life-cycle Support Type 1|rw|
|CANVAS|Constant image uniform color|r|
|CAPTION|Caption|r|
|CIN|Cineon Image File|rw|
|CLIP|Image Clip Mask|rwm|
|CLIPBOARD|The system clipboard|rw|
|CMYK|Raw cyan, magenta, yellow, and black samples|rwm|
|CMYKA|Raw cyan, magenta, yellow, black, and alpha samples|rwm|
|CR2|Canon Digital Camera Raw Image Format|r|
|CRW|Canon Digital Camera Raw Image Format|r|
|CUR|Microsoft icon|rw|
|CUT|DR Halo|r|
|DCM|Digital Imaging and Communications in Medicine image|r|
|DCR|Kodak Digital Camera Raw Image File|r|
|DCX|ZSoft IBM PC multi-page Paintbrush|rwm|
|DDS|Microsoft DirectDraw Surface|rwm|
|DFONT|Multi-face font package|r|
|DNG|Digital Negative|r|
|DPX|SMPTE 268M-2003 (DPX 2.0)|rw|
|DXT1|Microsoft DirectDraw Surface|rwm|
|DXT5|Microsoft DirectDraw Surface|rwm|
|EMF|Windows Enhanced Meta File|r|
|EPDF|Encapsulated Portable Document Format|rw|
|EPI|Encapsulated PostScript Interchange format|rw|
|EPS|Encapsulated PostScript|rw|
|EPSF|Encapsulated PostScript|rw|
|EPSI|Encapsulated PostScript Interchange format|rw|
|EPT|Encapsulated PostScript with TIFF preview|rw|
|EPT2|Encapsulated PostScript Level II with TIFF preview|rw|
|EPT3|Encapsulated PostScript Level III with TIFF preview|rwm|
|ERF|Epson RAW Format|r|
|EXR|High Dynamic-range (HDR)|rw|
|FAX|Group 3 FAX|rwm|
|FILE|Uniform Resource Locator (file://)|r|
|FITS|Flexible Image Transport System|rw|
|FLIF|Free Lossless Image Format|rwm|
|FRACTAL|Plasma fractal image|r|
|FTP|Uniform Resource Locator (ftp://)|r|
|FTS|Flexible Image Transport System|rw|
|G|Raw green samples|rwm|
|G3|Group 3 FAX|rw|
|G4|Group 4 FAX|rw|
|GIF|CompuServe graphics interchange format|rwm|
|GIF87|CompuServe graphics interchange format|rw|
|GRADIENT|Gradual linear passing from one shade to another|r|
|GRAY|Raw gray samples|rwm|
|GROUP4|Raw CCITT Group4|rw|
|HALD|Identity Hald color lookup table image|r|
|HDR|Radiance RGBE image format|rwm|
|HRZ|Slow Scan TeleVision|rw|
|HTTP|Uniform Resource Locator (http://)|r|
|HTTPS|Uniform Resource Locator (https://)|r|
|ICB|Truevision Targa image|rw|
|ICO|Microsoft icon|rwm|
|ICON|Microsoft icon|rw|
|IIQ|Phase One Raw Image Format|r|
|INLINE|Base64-encoded inline images|rwm|
|IPL|IPL Image Sequence|rwm|
|J2C|JPEG-2000 Code Stream Syntax|rw|
|J2K|JPEG-2000 Code Stream Syntax|rw|
|JNG|JPEG Network Graphics|rw|
|JNX|Garmin tile format|r|
|JP2|JPEG-2000 File Format Syntax|rw|
|JPC|JPEG-2000 Code Stream Syntax|rw|
|JPE|Joint Photographic Experts Group JFIF format|rw|
|JPEG|Joint Photographic Experts Group JFIF format|rw|
|JPG|Joint Photographic Experts Group JFIF format|rw|
|JPM|JPEG-2000 File Format Syntax|rw|
|JPS|Joint Photographic Experts Group JFIF format|rw|
|JPT|JPEG-2000 File Format Syntax|rw|
|K|Raw black samples|rwm|
|K25|Kodak Digital Camera Raw Image Format|r|
|KDC|Kodak Digital Camera Raw Image Format|r|
|LABEL|Image label|r|
|M|Raw magenta samples|rwm|
|M2V|MPEG Video Stream|rwm|
|M4V|Raw MPEG-4 Video|rwm|
|MAC|MAC Paint|r|
|MAP|Colormap intensities and indices|rw|
|MASK|Image Clip Mask|rwm|
|MAT|MATLAB level 5 image format|rwm|
|MEF|Mamiya Raw Image File|r|
|MIFF|Magick Image File Format|rwm|
|MKV|Multimedia Container|rwm|
|MNG|Multiple-image Network Graphics|rwm|
|MONO|Raw bi-level bitmap|rw|
|MOV|MPEG Video Stream|rwm|
|MP4|MPEG-4 Video Stream|rwm|
|MPC|Magick Persistent Cache image format|rwm|
|MPEG|MPEG Video Stream|rwm|
|MPG|MPEG Video Stream|rwm|
|MRW|Sony (Minolta) Raw Image File|r|
|MSL|Magick Scripting Language|rwm|
|MSVG|ImageMagick's own SVG internal renderer|rwm|
|MTV|MTV Raytracing image format|rwm|
|MVG|Magick Vector Graphics|rw|
|NEF|Nikon Digital SLR Camera Raw Image File|r|
|NRW|Nikon Digital SLR Camera Raw Image File|r|
|NULL|Constant image of uniform color|rw|
|O|Raw opacity samples|rwm|
|ORF|Olympus Digital Camera Raw Image File|r|
|OTB|On-the-air bitmap|rw|
|OTF|Open Type font|r|
|PAL|16bit/pixel interleaved YUV|rw|
|PALM|Palm pixmap|rwm|
|PAM|Common 2-dimensional bitmap format|rwm|
|PANGO|Pango Markup Language|r|
|PATTERN|Predefined pattern|r|
|PBM|Portable bitmap format (black and white)|rwm|
|PCD|Photo CD|rw|
|PCDS|Photo CD|rw|
|PCL|Printer Control Language|rwm|
|PCT|Apple Macintosh QuickDraw/PICT|rw|
|PCX|ZSoft IBM PC Paintbrush|rw|
|PDB|Palm Database ImageViewer Format|rwm|
|PDF|Portable Document Format|rwm|
|PDFA|Portable Document Archive Format|rwm|
|PEF|Pentax Electronic File|r|
|PES|Embrid Embroidery Format|r|
|PFA|Postscript Type 1 font (ASCII)|r|
|PFB|Postscript Type 1 font (binary)|r|
|PFM|Portable float format|rwm|
|PGM|Portable graymap format (gray scale)|rwm|
|PGX|JPEG 2000 uncompressed format|rw|
|PICON|Personal Icon|rw|
|PICT|Apple Macintosh QuickDraw/PICT|rw|
|PIX|Alias/Wavefront RLE image format|r|
|PJPEG|Joint Photographic Experts Group JFIF format|rw|
|PLASMA|Plasma fractal image|r|
|PNG|Portable Network Graphics|rw|
|PNG00|PNG inheriting bit-depth, color-type from original, if possible|rw|
|PNG24|opaque or binary transparent 24-bit RGB|rw|
|PNG32|opaque or transparent 32-bit RGBA|rw|
|PNG48|opaque or binary transparent 48-bit RGB|rw|
|PNG64|opaque or transparent 64-bit RGBA|rw|
|PNG8|8-bit indexed with optional binary transparency|rw|
|PNM|Portable anymap|rwm|
|PPM|Portable pixmap format (color)|rwm|
|PS|PostScript|rwm|
|PSB|Adobe Large Document Format|rwm|
|PSD|Adobe Photoshop bitmap|rwm|
|PTIF|Pyramid encoded TIFF|rwm|
|PWP|Seattle Film Works|r|
|R|Raw red samples|rwm|
|RADIAL-GRADIENT|Gradual radial passing from one shade to another|r|
|RAF|Fuji CCD-RAW Graphic File|r|
|RAS|SUN Rasterfile|rwm|
|RAW|Raw|r|
|RGB|Raw red, green, and blue samples|rwm|
|RGBA|Raw red, green, blue, and alpha samples|rwm|
|RGBO|Raw red, green, blue, and opacity samples|rwm|
|RGF|LEGO Mindstorms EV3 Robot Graphic Format (black and white)|rw|
|RLA|Alias/Wavefront image|r|
|RLE|Utah Run length encoded image|r|
|RMF|Raw Media Format|r|
|RW2|Panasonic Lumix Raw Image|r|
|SCR|ZX-Spectrum SCREEN$|r|
|SCREENSHOT|Screen shot|r|
|SCT|Scitex HandShake|r|
|SFW|Seattle Film Works|r|
|SGI|Irix RGB image|rwm|
|SIX|DEC SIXEL Graphics Format|rw|
|SIXEL|DEC SIXEL Graphics Format|rw|
|SR2|Sony Raw Format 2|r|
|SRF|Sony Raw Format|r|
|STEGANO|Steganographic image|r|
|SUN|SUN Rasterfile|rwm|
|SVG|Scalable Vector Graphics|rwm|
|SVGZ|Compressed Scalable Vector Graphics|rwm|
|TEXT|Text|r|
|TGA|Truevision Targa image|rw|
|TIFF|Tagged Image File Format|rwm|
|TIFF64|Tagged Image File Format (64-bit)|rw|
|TILE|Tile image with a texture|r|
|TIM|PSX TIM|r|
|TTC|TrueType font collection|r|
|TTF|TrueType font|r|
|TXT|Text|rwm|
|UYVY|16bit/pixel interleaved YUV|rw|
|VDA|Truevision Targa image|rw|
|VICAR|VICAR rasterfile format|rw|
|VID|Visual Image Directory|rwm|
|VIFF|Khoros Visualization image|rwm|
|VIPS|VIPS image|rwm|
|VST|Truevision Targa image|rw|
|WBMP|Wireless Bitmap (level 0) image|rw|
|WEBP|WebP Image Format|rw|
|WMF|Windows Meta File|r|
|WMV|Windows Media Video|rwm|
|WPG|Word Perfect Graphics|r|
|X3F|Sigma Camera RAW Picture File|r|
|XBM|X Windows system bitmap (black and white)|rw|
|XC|Constant image uniform color|r|
|XCF|GIMP image|r|
|XPM|X Windows system pixmap (color)|rw|
|XPS|Microsoft XML Paper Specification|r|
|XV|Khoros Visualization image|rwm|
|Y|Raw yellow samples|rwm|
|YCbCr|Raw Y, Cb, and Cr samples|rwm|
|YCbCrA|Raw Y, Cb, Cr, and alpha samples|rwm|
|YUV|CCIR 601 4:1:1 or 4:2:2|rw|

* Mac

|Format|Description|Mode|
|:-:|-|-|
|3FR|Hasselblad CFV/H3D39II|r|
|3G2|Media Container|r|
|3GP|Media Container|r|
|A|Raw alpha samples|rwm|
|AAI|AAI Dune image|rwm|
|AI|Adobe Illustrator CS2|rw|
|ART|PFS: 1st Publisher Clip Art|rw|
|ARW|Sony Alpha Raw Image Format|r|
|AVI|Microsoft Audio/Visual Interleaved|r|
|AVS|AVS X image|rwm|
|B|Raw blue samples|rwm|
|BGR|Raw blue, green, and red samples|rwm|
|BGRA|Raw blue, green, red, and alpha samples|rwm|
|BGRO|Raw blue, green, red, and opacity samples|rwm|
|BMP|Microsoft Windows bitmap image|rw|
|BMP2|Microsoft Windows bitmap image (V2)|rw|
|BMP3|Microsoft Windows bitmap image (V3)|rw|
|C|Raw cyan samples|rwm|
|CAL|Continuous Acquisition and Life-cycle Support Type 1|rw|
|CALS|Continuous Acquisition and Life-cycle Support Type 1|rw|
|CANVAS|Constant image uniform color|r|
|CAPTION|Caption|r|
|CIN|Cineon Image File|rw|
|CLIP|Image Clip Mask|rwm|
|CMYK|Raw cyan, magenta, yellow, and black samples|rwm|
|CMYKA|Raw cyan, magenta, yellow, black, and alpha samples|rwm|
|CR2|Canon Digital Camera Raw Image Format|r|
|CR3|Canon Digital Camera Raw Image Format|r|
|CRW|Canon Digital Camera Raw Image Format|r|
|CUBE|Cube LUT|r|
|CUR|Microsoft icon|rw|
|CUT|DR Halo|r|
|DATA|Base64-encoded inline images|rwm|
|DCM|Digital Imaging and Communications in Medicine image|r|
|DCR|Kodak Digital Camera Raw Image File|r|
|DCRAW|Raw Photo Decoder (dcraw)|r|
|DCX|ZSoft IBM PC multi-page Paintbrush|rwm|
|DDS|Microsoft DirectDraw Surface|rwm|
|DFONT|Multi-face font package|r|
|DNG|Digital Negative|r|
|DPX|SMPTE 268M-2003 (DPX 2.0)|rw|
|DXT1|Microsoft DirectDraw Surface|rwm|
|DXT5|Microsoft DirectDraw Surface|rwm|
|EPDF|Encapsulated Portable Document Format|rw|
|EPI|Encapsulated PostScript Interchange format|rw|
|EPS|Encapsulated PostScript|rw|
|EPSF|Encapsulated PostScript|rw|
|EPSI|Encapsulated PostScript Interchange format|rw|
|EPT|Encapsulated PostScript with TIFF preview|rw|
|EPT2|Encapsulated PostScript Level II with TIFF preview|rw|
|EPT3|Encapsulated PostScript Level III with TIFF preview|rwm|
|ERF|Epson RAW Format|r|
|EXR|High Dynamic-range (HDR)|rw|
|FAX|Group 3 FAX|rwm|
|FILE|Uniform Resource Locator (file://)|r|
|FITS|Flexible Image Transport System|rw|
|FLV|Flash Video Stream|rwm|
|FRACTAL|Plasma fractal image|r|
|FTP|Uniform Resource Locator (ftp://)|r|
|FTS|Flexible Image Transport System|rw|
|G|Raw green samples|rwm|
|G3|Group 3 FAX|rw|
|G4|Group 4 FAX|rw|
|GIF|CompuServe graphics interchange format|rwm|
|GIF87|CompuServe graphics interchange format|rw|
|GRADIENT|Gradual linear passing from one shade to another|r|
|GRAY|Raw gray samples|rwm|
|GRAYA|Raw gray and alpha samples|rwm|
|GROUP4|Raw CCITT Group4|rw|
|HALD|Identity Hald color lookup table image|r|
|HDR|Radiance RGBE image format|rwm|
|HRZ|Slow Scan TeleVision|rw|
|HTTP|Uniform Resource Locator (http://)|r|
|HTTPS|Uniform Resource Locator (https://)|r|
|ICB|Truevision Targa image|rw|
|ICO|Microsoft icon|rwm|
|ICON|Microsoft icon|rw|
|IIQ|Phase One Raw Image Format|r|
|INLINE|Base64-encoded inline images|rwm|
|IPL|IPL Image Sequence|rwm|
|J2C|JPEG-2000 Code Stream Syntax|rw|
|J2K|JPEG-2000 Code Stream Syntax|rw|
|JNG|JPEG Network Graphics|rw|
|JNX|Garmin tile format|r|
|JP2|JPEG-2000 File Format Syntax|rw|
|JPC|JPEG-2000 Code Stream Syntax|rw|
|JPE|Joint Photographic Experts Group JFIF format|rw|
|JPEG|Joint Photographic Experts Group JFIF format|rw|
|JPG|Joint Photographic Experts Group JFIF format|rw|
|JPM|JPEG-2000 File Format Syntax|rw|
|JPS|Joint Photographic Experts Group JFIF format|rw|
|JPT|JPEG-2000 File Format Syntax|rw|
|K|Raw black samples|rwm|
|K25|Kodak Digital Camera Raw Image Format|r|
|KDC|Kodak Digital Camera Raw Image Format|r|
|LABEL|Image label|r|
|M|Raw magenta samples|rwm|
|M2V|MPEG Video Stream|rwm|
|M4V|Raw MPEG-4 Video|rwm|
|MAC|MAC Paint|r|
|MAP|Colormap intensities and indices|rw|
|MASK|Image Clip Mask|rwm|
|MAT|MATLAB level 5 image format|rwm|
|MEF|Mamiya Raw Image File|r|
|MIFF|Magick Image File Format|rwm|
|MKV|Multimedia Container|rwm|
|MNG|Multiple-image Network Graphics|rwm|
|MONO|Raw bi-level bitmap|rw|
|MOV|MPEG Video Stream|rwm|
|MP4|MPEG-4 Video Stream|rwm|
|MPC|Magick Persistent Cache image format|rwm|
|MPEG|MPEG Video Stream|rwm|
|MPG|MPEG Video Stream|rwm|
|MRW|Sony (Minolta) Raw Image File|r|
|MSL|Magick Scripting Language|rwm|
|MSVG|ImageMagick's own SVG internal renderer|rwm|
|MTV|MTV Raytracing image format|rwm|
|MVG|Magick Vector Graphics|rw|
|NEF|Nikon Digital SLR Camera Raw Image File|r|
|NRW|Nikon Digital SLR Camera Raw Image File|r|
|NULL|Constant image of uniform color|rw|
|O|Raw opacity samples|rwm|
|ORF|Olympus Digital Camera Raw Image File|r|
|OTB|On-the-air bitmap|rw|
|OTF|Open Type font|r|
|PAL|16bit/pixel interleaved YUV|rw|
|PALM|Palm pixmap|rwm|
|PAM|Common 2-dimensional bitmap format|rwm|
|PATTERN|Predefined pattern|r|
|PBM|Portable bitmap format (black and white)|rwm|
|PCD|Photo CD|rw|
|PCDS|Photo CD|rw|
|PCL|Printer Control Language|rwm|
|PCT|Apple Macintosh QuickDraw/PICT|rw|
|PCX|ZSoft IBM PC Paintbrush|rw|
|PDB|Palm Database ImageViewer Format|rwm|
|PDF|Portable Document Format|rwm|
|PDFA|Portable Document Archive Format|rwm|
|PEF|Pentax Electronic File|r|
|PES|Embrid Embroidery Format|r|
|PFA|Postscript Type 1 font (ASCII)|r|
|PFB|Postscript Type 1 font (binary)|r|
|PFM|Portable float format|rwm|
|PGM|Portable graymap format (gray scale)|rwm|
|PGX|JPEG 2000 uncompressed format|rw|
|PICON|Personal Icon|rw|
|PICT|Apple Macintosh QuickDraw/PICT|rw|
|PIX|Alias/Wavefront RLE image format|r|
|PJPEG|Joint Photographic Experts Group JFIF format|rw|
|PLASMA|Plasma fractal image|r|
|PNG|Portable Network Graphics|rw|
|PNG00|PNG inheriting bit-depth, color-type from original, if possible|rw|
|PNG24|opaque or binary transparent 24-bit RGB|rw|
|PNG32|opaque or transparent 32-bit RGBA|rw|
|PNG48|opaque or binary transparent 48-bit RGB|rw|
|PNG64|opaque or transparent 64-bit RGBA|rw|
|PNG8|8-bit indexed with optional binary transparency|rw|
|PNM|Portable anymap|rwm|
|POCKETMOD|Pocketmod Personal Organizer|rwm|
|PPM|Portable pixmap format (color)|rwm|
|PS|PostScript|rwm|
|PSB|Adobe Large Document Format|rwm|
|PSD|Adobe Photoshop bitmap|rwm|
|PTIF|Pyramid encoded TIFF|rwm|
|PWP|Seattle Film Works|r|
|R|Raw red samples|rwm|
|RADIAL-GRADIENT|Gradual radial passing from one shade to another|r|
|RAF|Fuji CCD-RAW Graphic File|r|
|RAS|SUN Rasterfile|rwm|
|RAW|Raw|r|
|RGB|Raw red, green, and blue samples|rwm|
|RGB565|Raw red, green, blue samples in 565 format|r|
|RGBA|Raw red, green, blue, and alpha samples|rwm|
|RGBO|Raw red, green, blue, and opacity samples|rwm|
|RGF|LEGO Mindstorms EV3 Robot Graphic Format (black and white)|rw|
|RLA|Alias/Wavefront image|r|
|RLE|Utah Run length encoded image|r|
|RMF|Raw Media Format|r|
|RW2|Panasonic Lumix Raw Image|r|
|SCR|ZX-Spectrum SCREEN$|r|
|SCREENSHOT|Screen shot|r|
|SCT|Scitex HandShake|r|
|SFW|Seattle Film Works|r|
|SGI|Irix RGB image|rwm|
|SIX|DEC SIXEL Graphics Format|rw|
|SIXEL|DEC SIXEL Graphics Format|rw|
|SR2|Sony Raw Format 2|r|
|SRF|Sony Raw Format|r|
|STEGANO|Steganographic image|r|
|SUN|SUN Rasterfile|rwm|
|SVG|Scalable Vector Graphics|rwm|
|SVGZ|Compressed Scalable Vector Graphics|rwm|
|TEXT|Text|r|
|TGA|Truevision Targa image|rw|
|TIFF|Tagged Image File Format|rwm|
|TIFF64|Tagged Image File Format (64-bit)|rwm|
|TILE|Tile image with a texture|r|
|TIM|PSX TIM|r|
|TM2|PS2 TIM2|r|
|TTC|TrueType font collection|r|
|TTF|TrueType font|r|
|TXT|Text|rwm|
|UYVY|16bit/pixel interleaved YUV|rw|
|VDA|Truevision Targa image|rw|
|VICAR|VICAR rasterfile format|rw|
|VID|Visual Image Directory|rwm|
|VIFF|Khoros Visualization image|rwm|
|VIPS|VIPS image|rwm|
|VST|Truevision Targa image|rw|
|WBMP|Wireless Bitmap (level 0) image|rw|
|WEBP|WebP Image Format|rwm|
|WMV|Windows Media Video|rwm|
|WPG|Word Perfect Graphics|r|
|X3F|Sigma Camera RAW Picture File|r|
|XBM|X Windows system bitmap (black and white)|rw|
|XC|Constant image uniform color|r|
|XCF|GIMP image|r|
|XPM|X Windows system pixmap (color)|rw|
|XPS|Microsoft XML Paper Specification|r|
|XV|Khoros Visualization image|rwm|
|Y|Raw yellow samples|rwm|
|YCbCr|Raw Y, Cb, and Cr samples|rwm|
|YCbCrA|Raw Y, Cb, Cr, and alpha samples|rwm|
|YUV|CCIR 601 4:1:1 or 4:2:2|rw|
