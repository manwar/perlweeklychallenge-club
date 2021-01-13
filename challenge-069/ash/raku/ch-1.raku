#!/usr/bin/env raku

# Task 1 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-069/

# Comments: https://andrewshitov.com/2020/07/13/raku-challenge-week-69-issue-1/

my $a = 0;
my $b = 200;

put grep {
        $_ ~~ / ^ <[01689]>+ $ / &&
        $_ eq $_.trans('69' => '96').flip
    },
    $a..$b;

# Output:

# 0 1 8 11 69 88 96 101 111 181
