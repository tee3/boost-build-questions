Hi all,

I'm developing a Boost.Build module for generating a BSP for a bare
metal system running on a configurable device using a third-party tool
and found that adding the toolset to the usage-requirements of a
generated target did not work as I hoped or expected.

I created a minimal example to pass the toolset in the
usage-requirements just using an alias and found it generates a
warning and the toolset is not used.  I remember seeing something
about this on the mailing list, but I cannot remember the reasoning.

```
alias x : : : : <toolset>darwin-8 ;
exe hello : hello.cpp x ;
```

```
$ b2
warning: non-free usage requirements <toolset>darwin-8 ignored
warning: in main-target x at Jamroot:1
...found 8 targets...
...updating 5 targets...
clang-darwin.compile.c++ bin/clang-darwin-10.0/debug/hello.o
clang-darwin.link bin/clang-darwin-10.0/debug/hello
...updated 5 targets...
```

I really should have thought about this minimal example before I spent
a couple of hours trying this in my module and puzzling about the
result :)  

I would prefer not to require that the user set the toolset directly
on the top-level project.  I believe this would be complex for users
and less flexible than it could be.  I was hoping to be able to just
provide the BSP to the top-level target such that I could build the
target for any device supported by the third-party tool.

Do you see any way to work around this?  If not, I'll have to detect
errors within the generator if the toolset does not support the
architecture/instruction-set generated.

Best regards,
Tom
