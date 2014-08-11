#include <iostream>

#include "boost/thread.hpp"

void
print_hello ()
{
   std::cout << "Hello, world!\n";
}

int
main ()
{
   boost::thread t0 (print_hello);

   t0.join ();

   return 0;
}
