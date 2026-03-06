#!/usr/bin/env perl

use Modern::Perl;

my @n = @ARGV;

say "(", join(", ",
        map {$_->[0]}
        sort {$a->[1] != $b->[1] ? $a->[1] <=> $b->[1] : $a->[0] <=> $b->[0]}
        map {[$n[$_], sprintf("%b", $n[$_]) =~ tr/1/1/]} 0 .. $#n), ")";
