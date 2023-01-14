#!/usr/bin/env perl
# Perl weekly challenge 199
# Task 2:  Good Triplets
#
# See https://wlmb.github.io/2023/01/09/PWC199/#task-2-good-triplets
use v5.36;
use Algorithm::Combinatorics qw(combinations);
say(<<~"FIN"), exit unless @ARGV >= 6;
    Usage: $0 x y z N1 N2 N3 [N4...]
    to find all good pairs with given x y z from the set N1 N2 N3...
    FIN
my ($x, $y, $z, @l)=@ARGV;
my $good=grep {
    my ($p,$q,$r)=@$_;
    -$x<=$p-$q<=$x&&-$y<=$q-$r<=$y&&-$z<=$r-$p<=$z
} combinations(\@l,3);
say "$x $y $z: @l-> $good";
