# SYNOPSIS

A C++20 modules example

## Example

### boop.cc
```cc
module;
export module Beep.Boop;

export namespace Boop {
  auto burp () {
    return 0;
  }
}
```

### main.cc
```cc
import Beep.Boop;

int main() {
  return Boop::burp();
}
```

## Modules performance wins!

### First run

Precompile phase

```bash
%time ./build.sh
BEEP!
QUXX
./build.sh  0.80s user 0.09s system 62% cpu 1.434 total
```

### Second run

Compile with existing objects

```bash
%time ./build.sh
BEEP!
QUXX
./build.sh  0.07s user 0.03s system 47% cpu 0.200 total
```

