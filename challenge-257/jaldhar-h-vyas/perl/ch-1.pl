#!/usr/bin/perl
use 5.030;
use warnings;

my @ints = @ARGV;
my $n = scalar @ints - 1;
my %sorted = map { $_ => $n-- } reverse sort { $a <=> $b } @ints;

say q{(}, ( join q{, }, map { $sorted{$_} } @ints ), q{)};
