#!/usr/bin/env raku

#
# Perl Weekly Challenge - 075
#
# Task #2: Largest Rectangle Histogram
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-075
#

use v6.d;

sub MAIN(Str :$LIST = "2, 1, 4, 5, 3, 7") {
    my $list = prepare($LIST);
    chart($list).say;
    say "Largest Rectangle Histogram: " ~
        largest-rectangle-histogram($list);
}

#
#
# METHODS

sub largest-rectangle-histogram($list where .all ~~ Int) returns Int {

    my Int $i   = 0;
    my Int $max = 0;

    for 0 .. $list.elems-1 -> $i {

        my (Int $left, Int $right) = (0, 0);
        $left  = go-left($i, $list)  if $i > 0;
        $right = go-right($i, $list) if $i < $list.elems;

        my $heights = $list.[$i - $left .. $i + $right];
        my $size    = $heights.min * $heights.elems;

        $max = $size if $size > $max;
    }

    return $max;
}

sub go-left(Int $i is copy, $list where .all ~~ Int) returns Int {

    my $c = $list.[$i];
    my $j = 0;
    while $i > 0 {
        $i = $i - 1;
        last if $list.[$i] < $c;
        $j = $j + 1;
    }

    return $j;
}

sub go-right(Int $i is copy, $list where .all ~~ Int) returns Int {

    my $c = $list.[$i];
    my $j = 0;
    while $i < $list.elems-1 {
        $i += 1;
        last if $list.[$i] < $c;
        $j += 1;
    }

    return $j;
}

sub chart($list where .all ~~ Int) returns Str {

    my $max   = $list.max;
    my $chart = [];
    my $row   = 1;
    for 1 .. $max -> $n {
        my Str $data = "";
        for 0 .. $list.elems-1 -> $i {
            if $row <= $list.[$i] {
                $data ~= " #";
            }
            else {
                $data ~= "  ";
            }
        }

        $row += 1;

        $chart.push: sprintf("%d%s", $n, $data);
    }

    my (Str $histogram, Str $line, Str $size) = ("", "", "  ");
    $histogram = $chart.reverse.join("\n");
    $line ~= "_ " for 0 .. $list.elems;
    $size ~= $list.join(" ");

    return ($histogram, $line, $size).join("\n");
}

sub prepare(Str $list is copy) {

    return unless $list.defined;

    die "ERROR: Invalid list [$list].\n"
        unless $list ~~ /^[\s?\-?\d\,?\s?]+$/;

    $list ~~ s:g/\s//;
    return [ $list.split(',').map({ .Int }) ];
}
