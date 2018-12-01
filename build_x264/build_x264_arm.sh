# Created by jianxi on 2017/6/4
# https://github.com/mabeijianxi
# mabeijianxi@gmail.com

NDK=~/AndroidSdk/android-ndk-r15c

PLATFORM=$NDK/platforms/android-18/arch-arm
TOOLCHAIN=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64
PREFIX=./android/arm

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
	--host=arm-linux-androideabi \
	--cross-prefix=$TOOLCHAIN/bin/arm-linux-androideabi- \
	--sysroot=$PLATFORM \
	--extra-cflags="-Os -fpic" \
	--extra-ldflags="" \

	make clean
	make -j4
	make install

	cd ..
}
build_one
