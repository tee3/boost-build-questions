# Built tool for cross-compilation

This project is attempting to use a built tool (`built_tool`) to
operate on a cross-compiled target (`cross`).  For example, it is
often necessary to manipulate images for a target platform from the
host platform and sometimes this requires a custom tool built on the
host platform.

This is emulated by building `built_tool` with one compiler and
`cross` with another compiler.  Since this was tested on OS X, the
`built_tool` is built with `clang` and the `cross` target is built
with `gcc`.

The project as defined does not work as expected.  The results of
running this project on OS X are below.

The issues are:

1. The compiler command is empty when building the `cross` target.

2. The use of `built_tool` is correct except that it was expected that
   the `cross-final` target should be generated into the same
   directory as the `cross` target.

```
b2 -a -n
...found 13 targets...
...updating 5 targets...
gcc.compile.c bin/gcc/debug/cross.o

     -x c -O0 -fno-inline -Wall -g -fPIC     -c -o "bin/gcc/debug/cross.o" "cross.c"

gcc.link bin/gcc/debug/cross

        -o "bin/gcc/debug/cross"  "bin/gcc/debug/cross.o"       -g 

clang-darwin.compile.c bin/clang-darwin-4.2.1/debug/built_tool.o

    "clang++" -x c -O0 -g -O0 -fno-inline -Wall -g   -c -o "bin/clang-darwin-4.2.1/debug/built_tool.o" "built_tool.c"

clang-darwin.link bin/clang-darwin-4.2.1/debug/built_tool

    "clang++"   -o "bin/clang-darwin-4.2.1/debug/built_tool" "bin/clang-darwin-4.2.1/debug/built_tool.o"        -g

Jamfile</Users/tsc/Development/boost-build-questions/built-tool-cross>.built_tool bin/clang-darwin-4.2.1/debug/cross-final

  bin/clang-darwin-4.2.1/debug/built_tool bin/gcc/debug/cross bin/clang-darwin-4.2.1/debug/cross-final

...updated 5 targets...
```
