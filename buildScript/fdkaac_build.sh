#!/bin/sh

NDK=~/Android/android-ndk-r27

ANDROID_API=24

SYSROOT=$NDK/toolchains/llvm/prebuilt/linux-x86_64/sysroot

TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/linux-x86_64

CROSS_COMPILE=${TOOLCHAIN}/bin/aarch64-linux-android

CFLAGS=""

#export CXX="${CROSS_COMPILE}${ANDROID_API}-clang++"

export LDFLAGS=" -L$SYSROOT/usr/lib  $CFLAGS "

export CXXFLAGS=$CFLAGS

export CFLAGS=$CFLAGS

#export CC="${CROSS_COMPILE}${ANDROID_API}-clang"

export AR="$TOOLCHAIN/bin/llvm-ar"

export LD="$TOOLCHAIN/bin/ld"

export AS="$TOOLCHAIN/bin/llvm-as"



build_armv7a(){
  export CC=$TOOLCHAIN/bin/armv7a-linux-androideabi$ANDROID_API-clang
  export CXX=$TOOLCHAIN/bin/armv7a-linux-androideabi$ANDROID_API-clang++
  
  basepath=$(cd `dirname $0`; pwd)
  echo "$basepath"
  # 用作保存文件路径
  PREFIX=${basepath}/../android/arm-v7a

  ./configure --target=android --host=armv7a-linux-androideabi --enable-static --disable-shared --prefix=${PREFIX} --with-sysroot=${SYSROOT}
  
  $ADDITIONAL_CONFIGURE_FLAG
  make clean
  make -j4
  make install
   echo "$PREFIX"
}


build_armv8a(){
  export CC=$TOOLCHAIN/bin/aarch64-linux-android$ANDROID_API-clang
  export CXX=$TOOLCHAIN/bin/aarch64-linux-android$ANDROID_API-clang++
  
  basepath=$(cd `dirname $0`; pwd)
  echo "$basepath"
  # 用作保存文件路径
  PREFIX=${basepath}/../android/arm64-v8a


  ./configure --target=android --host=aarch64-linux-android --enable-static --disable-shared --prefix=${PREFIX} --with-sysroot=${SYSROOT}
  
  $ADDITIONAL_CONFIGURE_FLAG
  make clean
  make -j4
  make install
}


build_x86(){
  export CC=$TOOLCHAIN/bin/i686-linux-android$ANDROID_API-clang
  export CXX=$TOOLCHAIN/bin/i686-linux-android$ANDROID_API-clang++
  basepath=$(cd `dirname $0`; pwd)
  echo "$basepath"  
  # 用作保存文件路径
  PREFIX=${basepath}/../android/x86


  ./configure --target=android --host=i686-linux-android --enable-static --disable-shared --prefix=${PREFIX} --with-sysroot=${SYSROOT}
  
  $ADDITIONAL_CONFIGURE_FLAG
  make clean
  make -j4
  make install
  

}

build_x86_64(){
  export CC=$TOOLCHAIN/bin/x86_64-linux-android$ANDROID_API-clang
  export CXX=$TOOLCHAIN/bin/x86_64-linux-android$ANDROID_API-clang++
  basepath=$(cd `dirname $0`; pwd)
  echo "$basepath"  
  # 用作保存文件路径
  PREFIX=${basepath}/../android/x86_64


  ./configure --target=android --host=x86_64-linux-android --enable-static --disable-shared --prefix=${PREFIX} --with-sysroot=${SYSROOT}
  
  $ADDITIONAL_CONFIGURE_FLAG
  make clean
  make -j4
  make install
  
  
}

cd ../fdk-aac-2.0.3
build_armv7a
build_armv8a
build_x86
build_x86_64
cd ../buildScript
