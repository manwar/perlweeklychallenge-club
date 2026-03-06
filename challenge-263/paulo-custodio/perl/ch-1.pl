#!/usr/bin/env perl

use Modern::Perl;

my($k, @ints) = @ARGV;
@ints = sort {$a <=> $b} @ints;
my @idx =
        map {$_->[0]}
        grep {$_->[1] == $k}
        map {[$_, $ints[$_]]} 0 .. $#ints;
say "(", join(", ", @idx), ")";
