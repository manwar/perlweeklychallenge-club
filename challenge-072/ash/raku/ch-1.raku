#!/usr/bin/env raku

# Task 1 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-072/

# Comments: https://andrewshitov.com/2020/08/04/raku-challenge-week-72/

unit sub MAIN(Int $n);

my $f = [*] 1..$n;
say "$n! = $f";
# $f ~~ / 0+! $/;
# say ($f ~~ / 0+ $/).chars;
say ($f ~~ / 0+ $/ // '').chars;
