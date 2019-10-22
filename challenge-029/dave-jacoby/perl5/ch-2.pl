#!/usr/bin/env perl

# Task #2
# Write a script to demonstrate calling a C function.
# It could be any user defined or standard C function.

# another instance where I'm copying and pasting from other sources
# and cannot really claim that I wrote this.

# https://metacpan.org/pod/Inline

use Inline C;

print "9 + 16 = ", add( 9, 16 ), "\n";
print "9 - 16 = ", subtract( 9, 16 ), "\n";

__END__
__C__
int add(int x, int y) {
  return x + y;
}
 
int subtract(int x, int y) {
  return x - y;
}
