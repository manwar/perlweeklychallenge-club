#!/bin/env perl

use Modern::Perl;

my @list = @ARGV;
my($min_gap, @dummy) =
        map {$_->[0]}
        sort {$a->[1] <=> $b->[1]}
        map {[$list[$_], abs($list[$_]-$list[$_-1])]} 1..$#list;
say $min_gap;
