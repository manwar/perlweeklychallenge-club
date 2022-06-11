#!/usr/bin/env raku

=begin pod

Week 156:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-156

Task #1: Pernicious Numbers

    Write a script to permute first 10 Pernicious Numbers.

=end pod

use Test;

is pernicious-numbers(10), [3, 5, 6, 7, 9, 10, 11, 12, 13, 14], 'Example';

done-testing;

#
#
# METHOD

sub pernicious-numbers(Int $n) {

    my $i  = 1;
    my $pn = [];
    while ($pn.elems < $n) {
        my $bin  = $i.base(2);
        my $sum += $_ for ($bin.split(""));
        $pn.push: $i if $sum.is-prime;
        $i++;
    }

    return $pn;
}
