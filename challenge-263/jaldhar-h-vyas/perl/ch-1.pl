#!/usr/bin/perl
use 5.030;
use warnings;

my $k = shift;
my @ints = @ARGV;

my  @sorted = sort { $a <=> $b } @ints;
say q{(}, (join q{, }, grep { $sorted[$_] == $k} keys @sorted), q{)};