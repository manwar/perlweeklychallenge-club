#!/usr/bin/env raku

=begin pod

Week 157:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-157

Task #1: Pythagorean Numbers

    You are given a set of integers.

    Write a script to compute all three Pythagorean Means i.e Arithmetic Mean, Geometric Mean and Harmonic Mean of the given set of integers.

=end pod

use Test;

is am([1, 3, 5, 6, 9]),  '4.8', 'Example 1 - AM';
is gm([1, 3, 5, 6, 9]),  '3.8', 'Example 1 - GM';
is hm([1, 3, 5, 6, 9]),  '2.8', 'Example 1 - HM';

is am([2, 4, 6, 8, 10]), '6.0', 'Example 2 - AM';
is gm([2, 4, 6, 8, 10]), '5.2', 'Example 2 - GM';
is hm([2, 4, 6, 8, 10]), '4.4', 'Example 2 - HM';

is am([1, 2, 3, 4, 5]),  '3.0', 'Example 3 - AM';
is gm([1, 2, 3, 4, 5]),  '2.6', 'Example 3 - GM';
is hm([1, 2, 3, 4, 5]),  '2.2', 'Example 3 - HM';

done-testing;

#
#
# METHODS:

sub am($n) {

    my $am = [+] |$n;
    return sprintf("%.1f", $am / $n.elems);
}

sub gm($n) {

    my $gm = [*] |$n;
    return sprintf("%.1f", $gm ** (1 / $n.elems));
}

sub hm($n) {

    my $_n = map { 1 / $_ }, |$n;
    my $hm = [+] $_n;
    return sprintf("%.1f", $n.elems / $hm);
}
