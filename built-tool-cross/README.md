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

The results of running this project on OS X are shown below.  This
still requires an update to use a `<platform>` feature to drive the
requirements as in the original project, but this is a start on
getting things going.

The `cross-final-c` target provides the correct results, though the
version has to be explicitly stated in order for the directory for the
`cross-final-c` target to be correct (darwin-4.2.1 like the `cross`
target).  Furthermore, it would be best not to put any requirements on
the built tool other than it needs to run on the current host.

When builing the `cross-final-a` target (which is intended to be used
on the target platform), `cross-file-a` is generated into
`bin/clang-darwin-4.2.1/debug/cross-final-a`, which is the host
location, instead of the location of the of the `cross` target
`bin/darwin-4.2.1/debug/cross`.  This is a little hard to read due to
the fact that the name of the `darwin` and `clang` toolsets on OS X
both start with darwin.

When building the `cross-final-b` target (which has a requirement on
`darwin`), the `built_tool` target is built for `darwin` instead of
`clang`.

## cross-final-c

```
b2 cross-final-c -a -n
...found 13 targets...
...updating 9 targets...
common.mkdir bin/darwin-4.2.1

        mkdir -p "bin/darwin-4.2.1"

common.mkdir bin/darwin-4.2.1/debug

        mkdir -p "bin/darwin-4.2.1/debug"

darwin.compile.c bin/darwin-4.2.1/debug/cross.o

    "g++" -x c -O0 -fno-inline -Wall -g -dynamic -gdwarf-2 -fexceptions -fPIC     -c -o "bin/darwin-4.2.1/debug/cross.o" "cross.c"

darwin.link bin/darwin-4.2.1/debug/cross

    "g++"  -o "bin/darwin-4.2.1/debug/cross" "bin/darwin-4.2.1/debug/cross.o"       -g


common.mkdir bin/clang-darwin-4.2.1

        mkdir -p "bin/clang-darwin-4.2.1"

common.mkdir bin/clang-darwin-4.2.1/debug

        mkdir -p "bin/clang-darwin-4.2.1/debug"

clang-darwin.compile.c bin/clang-darwin-4.2.1/debug/built_tool.o

    "clang++" -x c -O0 -g -O0 -fno-inline -Wall -g   -c -o "bin/clang-darwin-4.2.1/debug/built_tool.o" "built_tool.c"

clang-darwin.link bin/clang-darwin-4.2.1/debug/built_tool

    "clang++"   -o "bin/clang-darwin-4.2.1/debug/built_tool" "bin/clang-darwin-4.2.1/debug/built_tool.o"        -g

Jamfile</Users/tsc/Development/boost-build-questions/built-tool-cross>.built_tool bin/darwin-4.2.1/debug/cross-final-c

  bin/clang-darwin-4.2.1/debug/built_tool bin/darwin-4.2.1/debug/cross bin/darwin-4.2.1/debug/cross-final-c

...updated 9 targets...
```

## cross-final-b

```
b2 cross-final-b -a -n
...found 13 targets...
...updating 10 targets...
common.mkdir bin

        mkdir -p "bin"

common.mkdir bin/darwin

        mkdir -p "bin/darwin"

common.mkdir bin/darwin/debug

        mkdir -p "bin/darwin/debug"

common.mkdir bin/darwin-4.2.1

        mkdir -p "bin/darwin-4.2.1"

common.mkdir bin/darwin-4.2.1/debug

        mkdir -p "bin/darwin-4.2.1/debug"

darwin.compile.c bin/darwin-4.2.1/debug/cross.o

    "g++" -x c -O0 -fno-inline -Wall -g -dynamic -gdwarf-2 -fexceptions -fPIC     -c -o "bin/darwin-4.2.1/debug/cross.o" "cross.c"

darwin.link bin/darwin-4.2.1/debug/cross

    "g++"  -o "bin/darwin-4.2.1/debug/cross" "bin/darwin-4.2.1/debug/cross.o"       -g


darwin.compile.c bin/darwin-4.2.1/debug/built_tool.o

    "g++" -x c -O0 -fno-inline -Wall -g -dynamic -gdwarf-2 -fexceptions -fPIC     -c -o "bin/darwin-4.2.1/debug/built_tool.o" "built_tool.c"

darwin.link bin/darwin-4.2.1/debug/built_tool

    "g++"  -o "bin/darwin-4.2.1/debug/built_tool" "bin/darwin-4.2.1/debug/built_tool.o"       -g


Jamfile</Users/tsc/Development/boost-build-questions/built-tool-cross>.built_tool bin/darwin/debug/cross-final-b

  bin/darwin-4.2.1/debug/built_tool bin/darwin-4.2.1/debug/cross bin/darwin/debug/cross-final-b

...updated 10 targets...
```

## cross-final-a

```
b2 cross-final-a -a -n
...found 13 targets...
...updating 9 targets...
common.mkdir bin/clang-darwin-4.2.1

        mkdir -p "bin/clang-darwin-4.2.1"

common.mkdir bin/clang-darwin-4.2.1/debug

        mkdir -p "bin/clang-darwin-4.2.1/debug"

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

Jamfile</Users/tsc/Development/boost-build-questions/built-tool-cross>.built_tool bin/clang-darwin-4.2.1/debug/cross-final-a

  bin/clang-darwin-4.2.1/debug/built_tool bin/darwin-4.2.1/debug/cross bin/clang-darwin-4.2.1/debug/cross-final-a

...updated 9 targets...
```
