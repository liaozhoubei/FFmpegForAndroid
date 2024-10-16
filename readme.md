## 使用说明

使用 android-ndk-r27 ，其他源码目录如下

    ffmpeg
        buildScript   脚本文件夹
        x264    
        fdk-aac-2.0.3  
        ffmpeg-7.1  
        android 生成的库文件安装路径

手动创建 x264/fdkaac/ffmpeg 源码路径，并把源码放入对应路径中

### 注意事项：

#### fdk-aac 编译

fdk-aac 从 2.0.1 版本开始就已经集成进了 Android 系统中，所以不集成也没有问题，但是此次也集成了。
问题在于它现在不适用 NDK 来编译，因此会出现 fdk-aac-2.0.2/libSBRdec/src/lpp_tran.cpp文件下，它引用了一个找不到的头文件"log/log.h"，从而导致编译失败。

解决方法有两种：

 1. 把它替换成"android/log.h",同时将 android_errorWriteLog方法注释掉,如果你很看重这段log的话你可以替换成自己的log（可以但不是很必要），你其实也可以把有__ANDROID__包裹的三段都注释掉。 稍等一会不出意外的话我们就能在我们设置的PREFIX路径看到我们的.so库和头文件之类。
 2. 手动使用脚本修补
  
        dumy missing log.h, ignore function impl.
        # mkdir -p 表示当路径不存在时创建路径，可创建多级目录，此处创建 log 目录
        mkdir -p libSBRdec/include/log/
        # 使用 echo 生成并文件将字符串写入文件
        echo "void android_errorWriteLog(int i, const char *string){}" > libSBRdec/include/log/log.h

### 源码下载

FDK-AAC:    https://downloads.sourceforge.net/opencore-amr/fdk-aac-2.0.3.tar.gz

x264:       git clone https://code.videolan.org/videolan/x264.git

ffmpeg:     https://ffmpeg.org/releases/ffmpeg-7.1.tar.xz 
