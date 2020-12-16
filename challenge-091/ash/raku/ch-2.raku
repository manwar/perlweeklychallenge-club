#!/usr/bin/env raku
#
# Task 2 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-091/

# Comments: https://andrewshitov.com/2020/12/14/raku-challenge-week-91/

# $ raku ch-2.raku 1 2 1 2
# 1

# $ raku ch-2.raku 2 1 1 0 2
# 0

unit sub MAIN(*@a);

my $pos = 0;
$pos += @a[$pos] while @a[$pos] && $pos < @a.end;
say $pos == @a.end ?? 1 !! 0;
