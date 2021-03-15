#!/usr/bin/env perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-095/
# TASK #1 › Palindrome Number

use 5.030;
use warnings;

my $N = shift;

say $N eq reverse($N) ? 1 : 0;
