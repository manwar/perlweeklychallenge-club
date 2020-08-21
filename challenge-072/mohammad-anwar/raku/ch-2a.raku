#!/usr/bin/env raku

#
# Perl Weekly Challenge - 072
#
# Task #2: Lines Range
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-072
#

use Test;

my Str $file   = "input.txt";
my @test-cases = (
    { A => 1, B => 3, O => ['L1','L2','L3'] },
    { A => 2, B => 4, O => ['L2','L3','L4'] },
    { A => 3, B => 5, O => ['L3','L4','L5'] },
    { A => 4, B => 6, O => ['L4','L5','L6'] },
    { A => 5, B => 7, O => ['L5','L6','L7'] },
);

for @test-cases -> $test {
    is-deeply lines-range($file, $test{<A>}, $test<B>),
              $test{<O>},
              "testing A=$test{<A>}, B=$test{<B>}";
}

done-testing;

sub lines-range(Str $file, Int $A is copy, Int $B is copy) {

    my @lines = Empty;
    for --$A .. --$B -> $i {
        @lines.push: $file.IO.lines[$i];
    }

    return @lines;
}
