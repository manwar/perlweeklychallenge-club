#!/usr/bin/env perl

use Modern::Perl;

my @ints = @ARGV;
say scalar grep {length($_) % 2 == 0} @ints;
