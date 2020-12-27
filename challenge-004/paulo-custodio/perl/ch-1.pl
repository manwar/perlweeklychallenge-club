#!/usr/bin/perl

# Challenge 004
# 
# Challenge #1
# Write a script to output the same number of PI digits as the size of your script. Say, if your script size is 10, it should print 3.141592653.

use strict;
use warnings;
use 5.030;

# we need a big-math library to compute any large number of digits; pi is offered for free!
use Math::Big 'pi';

my $size = -s $0;				# size of script
my $pi = pi();
say substr($pi, 0, $size+1);	# +1 to account for decimal dot
