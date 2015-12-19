# Built tool for cross-compilation

This project is attempting to use a built tool (`built_tool`) to
operate on a cross-compiled target (`cross`).  For example, it is
often necessary to manipulate images for a target platform from the
host platform and sometimes this requires a custom tool built on the
host platform.

This is emulated by building `built_tool` for
`<platform>platform-host` and `cross` with for `<platform>platform-a`.
`<platform>platform-host` has one requirement of `<toolset>clang` and
`<platform>platform-a` has one requirement of `<toolset>darwin-4.2.1`.

The `cross-final-c` target provides the correct results, though the
version has to be explicitly stated in order for the directory for the
`cross-final-c` target to be correct (`darwin-4.2.1` like the `cross`
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
$ b2 cross-final-c -a -n
...found 15 targets...
...updating 11 targets...
common.mkdir bin/debug

        mkdir -p "bin/debug"

common.mkdir bin/debug/platform-platform-a

        mkdir -p "bin/debug/platform-platform-a"

common.mkdir bin/darwin-4.2.1

        mkdir -p "bin/darwin-4.2.1"

common.mkdir bin/darwin-4.2.1/debug

        mkdir -p "bin/darwin-4.2.1/debug"

common.mkdir bin/darwin-4.2.1/debug/platform-platform-a

        mkdir -p "bin/darwin-4.2.1/debug/platform-platform-a"

darwin.compile.c bin/darwin-4.2.1/debug/platform-platform-a/cross.o

    "g++" -x c -O0 -fno-inline -Wall -g -dynamic -gdwarf-2 -fexceptions -fPIC     -c -o "bin/darwin-4.2.1/debug/platform-platform-a/cross.o" "cross.c"

darwin.link bin/darwin-4.2.1/debug/platform-platform-a/cross

    "g++"  -o "bin/darwin-4.2.1/debug/platform-platform-a/cross" "bin/darwin-4.2.1/debug/platform-platform-a/cross.o"       -g


common.mkdir bin/debug/platform-platform-host

        mkdir -p "bin/debug/platform-platform-host"

clang-darwin.compile.c bin/debug/platform-platform-host/built_tool.o

    "clang++" -x c -O0 -g -O0 -fno-inline -Wall -g   -c -o "bin/debug/platform-platform-host/built_tool.o" "built_tool.c"

clang-darwin.link bin/debug/platform-platform-host/built_tool

    "clang++"   -o "bin/debug/platform-platform-host/built_tool" "bin/debug/platform-platform-host/built_tool.o"        -g

Jamfile</Users/tsc/Development/boost-build-questions/built-tool-cross>.built_tool bin/debug/platform-platform-a/cross-final-c

  bin/debug/platform-platform-host/built_tool bin/darwin-4.2.1/debug/platform-platform-a/cross bin/debug/platform-platform-a/cross-final-c

...updated 11 targets...
```

## cross-final-b

```
$ b2 cross-final-b -a -n
...found 14 targets...
...updating 10 targets...
common.mkdir bin/debug

        mkdir -p "bin/debug"

common.mkdir bin/debug/platform-platform-a

        mkdir -p "bin/debug/platform-platform-a"

common.mkdir bin/darwin-4.2.1

        mkdir -p "bin/darwin-4.2.1"

common.mkdir bin/darwin-4.2.1/debug

        mkdir -p "bin/darwin-4.2.1/debug"

common.mkdir bin/darwin-4.2.1/debug/platform-platform-a

        mkdir -p "bin/darwin-4.2.1/debug/platform-platform-a"

darwin.compile.c bin/darwin-4.2.1/debug/platform-platform-a/cross.o

    "g++" -x c -O0 -fno-inline -Wall -g -dynamic -gdwarf-2 -fexceptions -fPIC     -c -o "bin/darwin-4.2.1/debug/platform-platform-a/cross.o" "cross.c"

darwin.link bin/darwin-4.2.1/debug/platform-platform-a/cross

    "g++"  -o "bin/darwin-4.2.1/debug/platform-platform-a/cross" "bin/darwin-4.2.1/debug/platform-platform-a/cross.o"       -g


darwin.compile.c bin/darwin-4.2.1/debug/platform-platform-a/built_tool.o

    "g++" -x c -O0 -fno-inline -Wall -g -dynamic -gdwarf-2 -fexceptions -fPIC     -c -o "bin/darwin-4.2.1/debug/platform-platform-a/built_tool.o" "built_tool.c"

darwin.link bin/darwin-4.2.1/debug/platform-platform-a/built_tool

    "g++"  -o "bin/darwin-4.2.1/debug/platform-platform-a/built_tool" "bin/darwin-4.2.1/debug/platform-platform-a/built_tool.o"       -g


Jamfile</Users/tsc/Development/boost-build-questions/built-tool-cross>.built_tool bin/debug/platform-platform-a/cross-final-b

  bin/darwin-4.2.1/debug/platform-platform-a/built_tool bin/darwin-4.2.1/debug/platform-platform-a/cross bin/debug/platform-platform-a/cross-final-b

...updated 10 targets...
```

## cross-final-a

```
$ b2 cross-final-a -a -n
...found 14 targets...
...updating 10 targets...
common.mkdir bin/clang-darwin-4.2.1

        mkdir -p "bin/clang-darwin-4.2.1"

common.mkdir bin/clang-darwin-4.2.1/debug

        mkdir -p "bin/clang-darwin-4.2.1/debug"

common.mkdir bin/darwin-4.2.1

        mkdir -p "bin/darwin-4.2.1"

common.mkdir bin/darwin-4.2.1/debug

        mkdir -p "bin/darwin-4.2.1/debug"

common.mkdir bin/darwin-4.2.1/debug/platform-platform-a

        mkdir -p "bin/darwin-4.2.1/debug/platform-platform-a"

darwin.compile.c bin/darwin-4.2.1/debug/platform-platform-a/cross.o

    "g++" -x c -O0 -fno-inline -Wall -g -dynamic -gdwarf-2 -fexceptions -fPIC     -c -o "bin/darwin-4.2.1/debug/platform-platform-a/cross.o" "cross.c"

darwin.link bin/darwin-4.2.1/debug/platform-platform-a/cross

    "g++"  -o "bin/darwin-4.2.1/debug/platform-platform-a/cross" "bin/darwin-4.2.1/debug/platform-platform-a/cross.o"       -g


clang-darwin.compile.c bin/clang-darwin-4.2.1/debug/built_tool.o

    "clang++" -x c -O0 -g -O0 -fno-inline -Wall -g   -c -o "bin/clang-darwin-4.2.1/debug/built_tool.o" "built_tool.c"

clang-darwin.link bin/clang-darwin-4.2.1/debug/built_tool

    "clang++"   -o "bin/clang-darwin-4.2.1/debug/built_tool" "bin/clang-darwin-4.2.1/debug/built_tool.o"        -g

Jamfile</Users/tsc/Development/boost-build-questions/built-tool-cross>.built_tool bin/clang-darwin-4.2.1/debug/cross-final-a

  bin/clang-darwin-4.2.1/debug/built_tool bin/darwin-4.2.1/debug/platform-platform-a/cross bin/clang-darwin-4.2.1/debug/cross-final-a

...updated 10 targets...
```
