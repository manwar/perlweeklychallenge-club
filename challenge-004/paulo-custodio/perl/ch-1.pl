#!/usr/bin/perl

# Challenge 004
#
# Challenge #1
# Write a script to output the same number of PI digits as the size of your script.
# Say, if your script size is 10, it should print 3.141592653.
#
# we need a big-math library to compute any large number of digits

use Modern::Perl;

use Math::BigFloat;
say Math::BigFloat->bpi(-s $0);
