![version](https://img.shields.io/badge/version-17%2B-3E8B93)
![platform](https://img.shields.io/static/v1?label=platform&message=mac-intel%20|%20mac-arm%20|%20win-64&color=blue)
[![license](https://img.shields.io/github/license/miyako/4d-plugin-imagemagick-v2)](LICENSE)
![downloads](https://img.shields.io/github/downloads/miyako/4d-plugin-imagemagick-v2/total)

# 4d-plugin-imagemagick-v2

Updated version of [Tech Note: ImageMagick Plug-in](http://kb.4d.com/assetid=43892) by Thomas Maul.

Conversion to/from PICT or PDF is available, even on 64-bits!

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

* [Apple](formats-apple.md): 223
* [Intel](formats-intel.md): 224
* [Windows](formats-windows.md): 218

#### Remarks

* CAL,CALS is `rw` on Intel, `r` on Apple
* APNG,WEBM,PHM is Apple only
* TIFF,TIFF64,EPT,EPT2,EPT3,GROUP4,PTIF is Intel only
