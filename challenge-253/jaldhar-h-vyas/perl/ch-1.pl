#!/usr/bin/perl
use 5.030;
use warnings;

my $separator = shift;
say join q{,}, map { "\"$_\"" } grep { $_ } map { split /[$separator]/ } @ARGV;
