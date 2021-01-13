#!/usr/bin/env raku

#
# Perl Weekly Challenge - 067
#
# Task #1: Number Combinations
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-067/
#

use Test;

is number-combinations(5, 2),
   '[ [1, 2], [1, 3], [1, 4], [1, 5], [2, 3], [2, 4], [2, 5], [3, 4], [3, 5], [4, 5] ]',
          'testing m=5, n=2';
is number-combinations(5, 3),
   '[ [1, 2, 3], [1, 2, 4], [1, 2, 5], [1, 3, 4], [1, 3, 5], [1, 4, 5], [2, 3, 4], [2, 3, 5], [2, 4, 5], [3, 4, 5] ]',
   'testing m=5, n=3';
is number-combinations(5, 4),
   '[ [1, 2, 3, 4], [1, 2, 3, 5], [1, 2, 4, 5], [1, 3, 4, 5], [2, 3, 4, 5] ]',
   'testing m=5, n=4';
is number-combinations(5, 5),
   '[ [1, 2, 3, 4, 5] ]',
   'testing m=5, n=5';

done-testing;

sub number-combinations(Int $m where { $m > 0 },
                        Int $n where { $n > 0 }) {
    $n > $m and say "ERROR: Invalid n=$n (n <= m)" and exit;

    return sprintf("[ %s ]",
           (1..$m)
           .combinations($n)
           .map({ '['~$_.join(', ')~']' })
           .join(', '));
}
