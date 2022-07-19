#!/usr/bin/env raku

=begin pod

Week 174:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-174

Task #1: Disarium Numbers

    Write a script to generate first 19 Disarium Numbers.

=end pod

use Test;

is disarium-numbers(19),
   [ 0,1,2,3,4,5,6,7,8,9,89,135,175,518,598,1306,1676,2427,2646798 ];

done-testing;

#
#
# METHODS

sub is-disarium-number(Int $n where $n >= 0 --> Bool) {
    my @n = $n.comb;
    my $s = 0;
    $s += @n[$_] ** ($_ + 1) for 0 .. @n.elems - 1;

    return ($s == $n);
}

sub disarium-numbers(Int $n where $n > 0) {
    my $i  = 0;
    my $dn = [];
    while $dn.elems < $n {
        $dn.push: $i if is-disarium-number $i;
        $i++;
    }

    return $dn;
}
