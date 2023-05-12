set -e

WXWIDGETS_FOLDER=$PWD/wxwidgets-3.2.2.1

cd $WXWIDGETS_FOLDER || exit 1

_DUMP_VERSION=$(gcc -dumpversion)
_COMPILER_VERSION=${_DUMP_VERSION//.}${MSYSTEM}

echo "_COMPILER_VERSION := ${_COMPILER_VERSION}"

#####
## Cleanup start
#cd $WXWIDGETS_FOLDER/build/msw || exit 3
#mingw32-make -f makefile.gcc \
  #CFG=mono \
  #VENDOR=tims \
  #COMPILER_VERSION=$_COMPILER_VERSION \
  #CXXFLAGS=-std=gnu++11 \
  #MONOLITHIC=1 SHARED=1 UNICODE=1 BUILD=release clean
#mingw32-make -f makefile.gcc \
  #CFG=mono \
  #VENDOR=tims \
  #COMPILER_VERSION=$_COMPILER_VERSION \
  #CXXFLAGS=-std=gnu++11 \
  #MONOLITHIC=1 SHARED=1 UNICODE=1 BUILD=debug clean
##
## Cleanup Finish
#####

sed --in-place "s/#define wxUSE_GRAPHICS_DIRECT2D 0/#define wxUSE_GRAPHICS_DIRECT2D 1/" $WXWIDGETS_FOLDER/include/wx/msw/setup.h

## exit

cd $WXWIDGETS_FOLDER/build/msw || exit 3
mingw32-make -f makefile.gcc \
  CFG=mono \
  VENDOR=tims \
  COMPILER_VERSION=$_COMPILER_VERSION \
  CXXFLAGS=-std=gnu++11 \
  MONOLITHIC=1 SHARED=1 UNICODE=1 BUILD=release

cd $WXWIDGETS_FOLDER/build/msw || exit 3
mingw32-make -f makefile.gcc \
  CFG=mono \
  VENDOR=tims \
  COMPILER_VERSION=$_COMPILER_VERSION \
  CXXFLAGS=-std=gnu++11 \
  MONOLITHIC=1 SHARED=1 UNICODE=1 BUILD=debug

# echo "Finished"
