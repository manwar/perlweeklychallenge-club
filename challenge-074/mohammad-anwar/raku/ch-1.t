#!/usr/bin/env raku

#
# Perl Weekly Challenge - 074
#
# Task #1: Majority Element
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-074
#

use Test;

is find-majority-element("1, 2, 2, 3, 2, 4, 2"), 2, "example 1";
is find-majority-element("1, 3, 1, 2, 4, 5"),   -1, "example 2";

done-testing;

#
#
# METHOD

sub find-majority-element(Str $list is copy) {

    die "ERROR: Invalid list [$list].\n"
        unless $list ~~ /^[\s?\-?\d\,?\s?]+$/;

    $list ~~ s:g/\s//;
    my $l = [ $list.split(',') ];

    my $mid_point = floor($l.elems / 2);
    my %elements;
    $l.map({ %elements{$_}++ });
    my $top = %elements.sort({ $^b.value <=> $^a.value }).head;

    return ($top.value >= $mid_point) ?? ($top.key) !! (-1);
}
