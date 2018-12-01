# Created by jianxi on 2017/6/4
# https://github.com/mabeijianxi
# mabeijianxi@gmail.com

NDK=~/AndroidSdk/android-ndk-r15c

PLATFORM=$NDK/platforms/android-18/arch-mips/
TOOLCHAIN=$NDK/toolchains/mipsel-linux-android-4.9/prebuilt/linux-x86_64
PREFIX=./android/mips

function build_one
{
	cd ../x264

	./configure \
	--prefix=$PREFIX \
	--disable-shared \
	--enable-static \
	--disable-asm \
	--enable-pic \
	--enable-strip \
	--sysroot=$PLATFORM \
	--host=mipsel-linux \
	--cross-prefix=$TOOLCHAIN/bin/mipsel-linux-android- \
	--sysroot=$PLATFORM \
	--extra-cflags="-Os -fpic" \

	make clean
	make j8
	make install
	
	cd ..
}

build_one
