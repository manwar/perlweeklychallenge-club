#!/usr/bin/env raku

# Task 2 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-069/

# Comments: https://andrewshitov.com/2020/07/13/raku-challenge-week-69-issue-2/

multi sub S(0) {''}
multi sub S(1) {'0'}
multi sub S($n) {
    my $prev = S($n - 1);
    $prev ~ '0' ~ $prev.flip.trans('01' => '10')
}

# S($_) for ^25;
say "S$_ = {S($_)}" for ^9;

# say S(1000);
