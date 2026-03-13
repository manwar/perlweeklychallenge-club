#!/usr/bin/env perl

use Modern::Perl;
use List::Util 'sum';

my($k, @ints) = @ARGV;
say sum
    map {$_->[1]}
    grep {num_ones($_->[0]) == $k}
    map {[$_, $ints[$_]]} 0 .. $#ints;

sub num_ones {
    my($n) = @_;
    my $bin = sprintf("%b", $n);
    my $ones = $bin =~ tr/1/1/;
    return $ones;
}
