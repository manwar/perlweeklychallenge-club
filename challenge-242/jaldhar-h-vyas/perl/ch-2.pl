#!/usr/bin/perl
use 5.020;
use warnings;

my @matrix;
push @matrix,  map { [split q{ }, $_] } @ARGV;
@matrix = map { [ map { $_ ^ 1 } reverse @{$_} ] } @matrix;
say q{(} . (join q{, }, map { q{[} . (join q{, }, @{$_}) . q{]} } @matrix) . q{)};
