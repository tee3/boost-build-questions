This is an example Boost.Build project intended to show the behavior
of cxxflags when compiling C files.

This directory contains a Boost.Build project along with a C source
file.  To see the compiler options, run b2 in this directory with the
following options.

.. code:: sh

	  $ b2 -n -a

I was able to test the following locally:

- OS X

   - darwin (gcc) - OK
   - clang - FAIL

- Linux

   - gcc - OK
   - clang - OK (see below)

By inspection, at least the following seem to be incorrect as well:

- borland
- intel-darwin
