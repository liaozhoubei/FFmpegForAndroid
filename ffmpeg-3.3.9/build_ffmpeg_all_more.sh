# Created by jianxi on 2017/6/4
# https://github.com/mabeijianxi
# mabeijianxi@gmail.com

chmod a+x build_ffmpeg_*.sh

cd ../build_x264
chmod a+x build_x264_all.sh
./build_x264_all.sh

cd ../fdk-aac-0.1.6
chmod a+x build_fdk_aac_all.sh
./build_fdk_aac_all.sh

cd ../ffmpeg-3.3.9

# Build arm v6
./build_ffmpeg_arm_more.sh

# Build arm  v7a
./build_ffmpeg_arm_v7a_more.sh

# Build arm64 v8a
./build_ffmpeg_arm64_v8a_more.sh

# Build x86
./build_ffmpeg_x86_more.sh

# Build x86_64
./build_ffmpeg_x86_64_more.sh