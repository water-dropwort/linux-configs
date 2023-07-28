#!/bin/bash

src_dir="./configs"
src_files=`find $src_dir -type f`

for f in $src_files;
do
    #echo $f
    #echo $HOME${f:${#src_dir}}
    cp $f $HOME${f:${#src_dir}} -lrf
done

