#!/usr/bin/env bash

CXX=/opt/homebrew/opt/llvm@15/bin/clang++

$CXX -std=c++2b --precompile beep.cppm -fmodule-name=Socket.Beep -o beep.pcm
$CXX -std=c++2b -c beep.pcm -o beep.o

$CXX -std=c++2b --precompile boop.cppm -fmodule-name=Socket.Boop -o boop.pcm
$CXX -std=c++2b -c boop.pcm -o boop.o

$CXX -Wno-unused-command-line-argument -std=c++2b -fmodules-ts \
  -fmodule-file=beep.pcm beep.o \
  -fmodule-file=boop.pcm boop.o \
  -o main \
  main.cpp

rm *.o
rm *.pcm

./main
