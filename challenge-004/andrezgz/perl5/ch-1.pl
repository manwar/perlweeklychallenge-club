#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-004/
# Challenge #1
# Write a script to output the same number of PI digits as the size of your script.
# Say, if your script size is 10, it should print 3.141592653.

use strict;
use warnings;

use Math::BigFloat qw/bpi/;
print bpi(-s $0);
