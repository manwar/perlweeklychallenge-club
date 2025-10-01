#!/usr/bin/perl
use 5.038;
use warnings;

my $str = shift;
my $broken = shift // q{.};

say scalar grep { !/[$broken]/i } split /\s+/, $str;