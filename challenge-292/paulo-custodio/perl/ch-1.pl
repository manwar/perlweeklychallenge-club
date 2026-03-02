#!/usr/bin/env perl

use Modern::Perl;

my @nums = sort {$b->[1] <=> $a->[1]} map {[$_, $ARGV[$_]]} 0..$#ARGV;
if (@nums >= 2 && $nums[0][1] >= 2*$nums[1][1]) {
    say $nums[0][0];
}
else {
    say -1;
}
