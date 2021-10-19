#!/usr/bin/env perl

# TASK #1 > Pandigital Numbers
# Submitted by: Mohammad S Anwar
# Write a script to generate first 5 Pandigital Numbers in base 10.
# 
# As per the wikipedia, it says:
# 
# A pandigital number is an integer that in a given base has among its 
# significant digits each digit used in the base at least once.

# solution from https://oeis.org/A050278

use Modern::Perl;
use Math::Combinatorics;

my @A050278 = sort {$a<=>$b} map {0+join('', @$_)} grep {$_->[0]!=0} permute(0..9);
splice(@A050278, 5, $#A050278);
say join("\n", @A050278);