# Created by jianxi on 2017/6/4
# https://github.com/mabeijianxi
# mabeijianxi@gmail.com

NDK=~/AndroidSdk/android-ndk-r15c

PLATFORM=$NDK/platforms/android-21/arch-x86_64/
TOOLCHAIN=$NDK/toolchains/x86_64-4.9/prebuilt/linux-x86_64
PREFIX=./android/x86_64

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
	--host=x86_64-linux \
	--cross-prefix=$TOOLCHAIN/bin/x86_64-linux-android- \
	--sysroot=$PLATFORM \
	--extra-cflags="-Os -fpic" \
	--extra-ldflags="" \

	make clean
	make j8
	make install
	
	cd ..
}

build_one

