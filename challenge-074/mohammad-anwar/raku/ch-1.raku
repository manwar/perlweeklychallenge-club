#!/usr/bin/env raku

#
# Perl Weekly Challenge - 074
#
# Task #1: Majority Element
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-074
#

use v6.d;

sub MAIN(Str :$list = "1, 2, 2, 3, 2, 4, 2") {
    find-majority-element($list).say;
}

#
#
# METHOD

sub find-majority-element(Str $list is copy) {

    die "ERROR: Invalid list [$list].\n"
        unless $list ~~ /^[\s?\-?\d\,?\s?]+$/;

    say "List: $list";
    $list ~~ s:g/\s//;
    my $l = [ $list.split(',') ];

    my $mid_point = floor($l.elems / 2);
    my %elements;
    $l.map({ %elements{$_}++ });
    my $top = %elements.sort({ $^b.value <=> $^a.value }).head;

    return ($top.value >= $mid_point) ?? ($top.key) !! (-1);
}
