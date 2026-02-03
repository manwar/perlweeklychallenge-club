#!/usr/bin/env perl

use Modern::Perl;
use List::Util qw(sum);

my @nums = split ' ', <>;
my($x, $y) = split ' ', <>;
say sum(@nums[$x .. $y]);
