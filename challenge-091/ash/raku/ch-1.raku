#!/usr/bin/env raku
#
# Task 1 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-091/

# Also see ch-1a.raku

# Comments: https://andrewshitov.com/2020/12/14/raku-challenge-week-91/

unit sub MAIN(Int $n = 1122234);

print .Str.chars ~ .[0] for $n ~~ m:g/ (\d) $0* /;
say '';

# Output:
# 21321314
