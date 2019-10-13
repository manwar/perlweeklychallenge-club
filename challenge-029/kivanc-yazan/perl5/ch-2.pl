#!/usr/bin/env perl
use warnings;
use strict;
use Inline C => 'DATA';

# Problem:
# Write a script to demonstrate calling a C function.
# It could be any user defined or standard C function.

print "2 ** 2 = " . power(2,2) . "\n";
print "2 ** 4 = " . power(2,4) . "\n";
print "4 ** 4 = " . power(4,4) . "\n";

__DATA__
__C__
int power(int a, int b){
  return pow(a,b);
}
