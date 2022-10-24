# SYNOPSIS

A C++20 modules example

### First run

Precompile phase

```bash
%time ./build.sh
BEEP!
BOOP!
./build.sh  0.78s user 0.09s system 65% cpu 1.323 total
```

### Second run

Compile with existing objects

```bash
%time ./build.sh
BEEP!
BOOP!
./build.sh  0.08s user 0.03s system 58% cpu 0.180 total
```

