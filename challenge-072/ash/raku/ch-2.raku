#!/usr/bin/env raku

# Task 2 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-072/

# Comments: https://andrewshitov.com/2020/08/04/raku-challenge-week-72/

# Generating input.txt:
# $ raku -e'say "L$_" for 1..100' > input.txt

unit sub MAIN(Int $a, Int $b where 0 < $a <= $b <= 100);

.say for 'input.txt'.IO.lines[$a-1 ..^ $b];
