#!/usr/bin/env perl

# Perl Weekly Challenge 334 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-334/

use Modern::Perl;
use List::Util qw(sum);

my @nums = split ' ', <>;
my($x, $y) = split ' ', <>;
say sum(@nums[$x .. $y]);
