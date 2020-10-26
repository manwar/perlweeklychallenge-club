#!/usr/bin/env raku
#
# Task 1 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-084/
#
# $ raku ch-1.raku 1234
# 4321
#
# $ raku ch-1.raku -4321
# -1234
#
# $ raku ch-1.raku 2147483647
# 0
#
# $ raku ch-1.raku 2147483641
# 1463847412
#
# $ raku ch-1.raku -2147483641
# -1463847412
#
# $ raku ch-1.raku -2147483647
# 0

unit sub MAIN($n);

my $r = $n.sign * $n.abs.flip;
say -2147483648 <= $r <= 2147483647 ?? $r !! 0;
