#!/bin/bash

for file in $PWD/*
do
  if [[ $file != *"convert_hdr"* && $file != *"ffmpeg"* ]]; then
    echo "Converting $file ..."
    ./ffmpeg -analyzeduration 10M -probesize 10M -i $file -map 0:v:0 -map 0:a:0? -aspect 16:9 -vf scale=2560:1440,zscale=t=linear:npl=100,format=gbrpf32le,zscale=p=bt709,tonemap=tonemap=hable:desat=0,zscale=t=bt709:m=bt709:r=tv,format=yuv420p -c:v libx264 -preset fast -profile:v high -crf 18 -c:a aac -b:a 192k -y "${file::${#file}-4}_converted.mov"
  fi
done
