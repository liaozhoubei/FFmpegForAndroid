# Created by jianxi on 2017/6/4
# https://github.com/mabeijianxi
# mabeijianxi@gmail.com

NDK=~/AndroidSdk/android-ndk-r15c

PLATFORM=$NDK/platforms/android-21/arch-arm64/
TOOLCHAIN=$NDK/toolchains/aarch64-linux-android-4.9/prebuilt/linux-x86_64
PREFIX=./android/arm64-v8a

function build_one
{
	cd ../x264

	./configure \
	--prefix=$PREFIX \
	--disable-shared \
	--enable-static \
	--enable-pic \
	--enable-strip \
	--host=aarch64-linux \
	--cross-prefix=$TOOLCHAIN/bin/aarch64-linux-android- \
	--sysroot=$PLATFORM \
	--extra-cflags="-Os -fpic" \
	--extra-ldflags="" \

	make clean
	make -j4
	make install
	
	cd ..
}

build_one
