#!/usr/bin/env bash
#
# modules are only properly supported in llvm > 15, as of this writing,
# `brew install llvm` will get you everything you need to use this code.
# rtfm here - https://clang.llvm.org/docs/StandardCPlusPlusModules.html
#
CXX=/opt/homebrew/opt/llvm@15/bin/clang++

mkdir -p bin

if [ ! -d "build" ]; then
  mkdir build

  # precompile the `beep` module
  $CXX -std=c++2b              \
    -x c++-module              \
    --precompile src/beep.cc   \
    -fmodule-name=Socket.Beep  \
    -o build/beep.pcm

  # create an object file from the precompiled module that can be linked
  $CXX -std=c++2b -c build/beep.pcm -o build/beep.o

  # same procedure for the `quxx` module. order of compilation is important, we
  # need quxx to be precompiled before `boop` because `boop` will use it.
  $CXX -std=c++2b              \
    -x c++-module              \
    --precompile src/quxx.cc   \
    -fmodule-name=Socket.Quxx  \
    -o build/quxx.pcm

  # create an object file
  $CXX -std=c++2b -c build/quxx.pcm -o build/quxx.o

  #
  # `boop` uses `quxx`, so we need to specify the `-fmodule-file=<file>` flag.
  #

  # `-fimplicit-modules` automatically translates #include directives into
  # import statements.

  # `-fimplicit-module-maps` implicitly search the file system for module map
  # files. A module map file contains the mapping between existing headers and
  # the logical structure of a module.

  # `-x c++-module` allows you to specify any extension for a module file
  $CXX -std=c++2b                 \
    -x c++-module                 \
    --precompile src/boop.cc      \
    -fimplicit-modules            \
    -fmodule-file=build/quxx.pcm  \
    -fmodule-name=Socket.Boop     \
    -o build/boop.pcm

  # create an object file
  $CXX -std=c++2b -c build/boop.pcm -o build/boop.o
fi

## build archive
ar crus build/libmodules.a build/*.o

$CXX -std=c++2b                 \
  -fmodule-file=build/quxx.pcm  \
  -fmodule-file=build/beep.pcm  \
  -fmodule-file=build/boop.pcm  \
  -o bin/main                   \
  build/libmodules.a            \
  src/main.cc

./bin/main

