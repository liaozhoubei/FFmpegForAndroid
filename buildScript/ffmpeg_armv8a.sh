#!/bin/sh

basepath=$(cd `dirname $0`; pwd)
#export TMPDIR=$basepath/ffmpegtemp
# NDK的路径，根据自己的安装位置进行设置
NDK=~/Android/android-ndk-r27
# 编译针对的平台，可以根据自己的需求进行设置
# 这里选择最低支持android-14, arm架构，生成的so库是放在
ANDROID_API=24
# libs/armeabi文件夹下的，若针对x86架构，要选择arch-x86
#PLATFORM=aarch64-linux-android

# 工具链的路径，根据编译的平台不同而不同
# arm-linux-androideabi-4.9与上面设置的PLATFORM对应，4.9为工具的版本号，

# 根据自己安装的NDK版本来确定，一般使用最新的版本,编译链的路径：基于llvm的clang编译工具
TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/linux-x86_64

#sysroot 这个一定要设置成 ndk的llvm 路径下的 sysroot
SYSROOT=$TOOLCHAIN/sysroot

#要编译的架构，只有 aarch64-linux-android ,armv7a-linux-androideabi ,i686-linux-android ,x86_64-linux-android 四种 
ARCH=aarch64-linux-android
#完整的编译工具前缀
CROSS_PREFIX=$TOOLCHAIN/bin/$ARCH$ANDROID_API-clang

#配置ndk的clang/clang++的编译工具前缀
ANDROID_CROSS_PREFIX=$TOOLCHAIN/bin/$ARCH$ANDROID_API-clang++

export CC=$TOOLCHAIN/bin/$ARCH$ANDROID_API-clang
export CXX=$TOOLCHAIN/bin/$ARCH$ANDROID_API-clang++


AR=$TOOLCHAIN/bin/llvm-ar
AS=$TOOLCHAIN/bin/llvm-as
LD=$TOOLCHAIN/bin/ld
RANLIB=$TOOLCHAIN/bin/llvm-ranlib
STRIP=$TOOLCHAIN/bin/llvm-strip
NM=$TOOLCHAIN/bin/llvm-nm


CPU=arm64-v8a
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$basepath/../android/$CPU/lib/pkgconfig
echo $PKG_CONFIG_PATH

FDK_INCLUDE=$basepath/../android/$CPU/include

FDK_LIB=$basepath/../android/$CPU/lib

X264_INCLUDE=$basepath/../android/$CPU/include

X264_LIB=$basepath/../android/$CPU/lib

FF_EXTRA_CFLAGS=""
FF_CFLAGS="-I$ASM -isysroot $SYSROOT -O3 -Wall -pipe \
-ffast-math \
-fstrict-aliasing -Werror=strict-aliasing \
-Wno-psabi -Wa,--noexecstack \
-DANDROID  "

PREFIX=../android/$CPU

#rm "./compat/strtod.o"
echo $FDK_INCLUDE


build_armv8a(){

	#ASM 路径， 同上必须是llvm 目录下的 asm, armv7跟PLATFORM不匹配
	ASM=$SYSROOT/usr/include/$ARCH

	./configure \
	--prefix=$PREFIX \
	--enable-cross-compile \
	--disable-runtime-cpudetect \
	--arch=aarch64 \
	--target-os=android \
	--cc=$CC \
	--cross-prefix=$CROSS_PREFIX \
	--disable-stripping \
	--nm=$NM \
	--ar=$AR \
	--ranlib=$RANLIB \
	--sysroot=$SYSROOT \
	--pkg-config="pkg-config --static" \
	--extra-cflags="-I$X264_INCLUDE  -I$FDK_INCLUDE " \
	--extra-ldflags="-L$X264_LIB  -L$FDK_LIB " \
	--enable-gpl \
	--enable-shared \
	--enable-static \
	--enable-version3 \
	--enable-pthreads \
	--disable-iconv \
	--disable-encoders \
	--enable-libx264 \
	--enable-neon \
	--enable-x86asm \
	--enable-libfdk_aac \
	--enable-encoder=libx264 \
	--enable-encoder=libfdk_aac \
	--enable-encoder=mjpeg \
	--enable-encoder=png \
	--enable-nonfree \
	--enable-muxers \
	--enable-muxer=mov \
	--enable-muxer=mp4 \
	--enable-muxer=h264 \
	--enable-muxer=avi \
	--disable-decoders \
	--enable-decoder=aac \
	--enable-decoder=aac_latm \
	--enable-decoder=h264 \
	--enable-decoder=mpeg4 \
	--enable-decoder=mjpeg \
	--enable-decoder=png \
	--disable-demuxers \
	--enable-demuxer=image2 \
	--enable-demuxer=h264 \
	--enable-demuxer=aac \
	--enable-demuxer=avi \
	--enable-demuxer=mpc \
	--enable-demuxer=mov \
	--enable-demuxer=mpegts \
	--enable-jni \
	--enable-mediacodec \
	--enable-decoder=h264_mediacodec \
	--enable-decoder=h264_mediacodec \
	--enable-decoder=hevc_mediacodec \
	--enable-decoder=mpeg4_mediacodec \
	--disable-parsers \
	--enable-parser=aac \
	--enable-parser=ac3 \
	--enable-parser=h264 \
	--enable-protocols \
	--enable-zlib \
	--enable-avfilter \
	--disable-outdevs \
	--disable-ffprobe \
	--disable-ffplay \
	--disable-ffmpeg \
	--enable-debug \
	--disable-asm \
	--disable-stripping \
	--disable-small \
	--disable-ffprobe \
	--disable-ffplay \
	--disable-ffmpeg \
	--disable-postproc \
	--disable-avdevice \
	--disable-symver \
	--extra-cflags="$FF_EXTRA_CFLAGS  $FF_CFLAGS" \
	--extra-ldflags=""
}



cd ../ffmpeg-7.1

build_armv8a
make clean
make -j8
make install
cd ../buildScript


