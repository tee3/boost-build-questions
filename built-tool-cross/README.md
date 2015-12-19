# Built tool for cross-compilation

This project is attempting to use a built tool (`built_tool`) to
operate on a cross-compiled target (`cross`).  For example, it is
often necessary to manipulate images for a target platform from the
host platform and sometimes this requires a custom tool built on the
host platform.

This is emulated by building `built_tool` with one compiler and
`cross` with another compiler.  Since this was tested on OS X, the
`built_tool` is built with `clang` and the `cross` target is built
with `darwin`.

The project as defined does not work as expected.  The results of
running this project on OS X are below.

The issue is that the `cross-final` target (which is intended to be
used on the target platform) is generated into
`bin/clang-darwin-4.2.1/debug/cross-final`, which is the host
location, instead of the location of the of the `cross` target
`bin/darwin-4.2.1/debug/cross`.  This is a little confusing due to the
naming of the `darwin` and `clang` toolsets on OS X.

```
b2 -a -n
...found 13 targets...
...updating 7 targets...
common.mkdir bin/darwin-4.2.1

        mkdir -p "bin/darwin-4.2.1"

common.mkdir bin/darwin-4.2.1/debug

        mkdir -p "bin/darwin-4.2.1/debug"

darwin.compile.c bin/darwin-4.2.1/debug/cross.o

    "g++" -x c -O0 -fno-inline -Wall -g -dynamic -gdwarf-2 -fexceptions -fPIC     -c -o "bin/darwin-4.2.1/debug/cross.o" "cross.c"

darwin.link bin/darwin-4.2.1/debug/cross

    "g++"  -o "bin/darwin-4.2.1/debug/cross" "bin/darwin-4.2.1/debug/cross.o"       -g


clang-darwin.compile.c bin/clang-darwin-4.2.1/debug/built_tool.o

    "clang++" -x c -O0 -g -O0 -fno-inline -Wall -g   -c -o "bin/clang-darwin-4.2.1/debug/built_tool.o" "built_tool.c"

clang-darwin.link bin/clang-darwin-4.2.1/debug/built_tool

    "clang++"   -o "bin/clang-darwin-4.2.1/debug/built_tool" "bin/clang-darwin-4.2.1/debug/built_tool.o"        -g

Jamfile</Users/tsc/Development/boost-build-questions/built-tool-cross>.built_tool bin/clang-darwin-4.2.1/debug/cross-final

  bin/clang-darwin-4.2.1/debug/built_tool bin/darwin-4.2.1/debug/cross bin/clang-darwin-4.2.1/debug/cross-final

...updated 7 targets...
```
