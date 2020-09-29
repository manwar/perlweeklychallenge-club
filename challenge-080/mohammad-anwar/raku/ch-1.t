#!/usr/bin/env raku

#
# Perl Weekly Challenge - 080
#
# Task #1: Smallest Positive Number
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-080
#

use Test;

# examples from the task
is smallest-positive-number((5, 2, -2, 0)),  1,
   "testing (5, 2, -2, 0)";
is smallest-positive-number((1, 8, -1)),     2,
   "testing (1, 8, -1)";
is smallest-positive-number((2, 0, -1)),     1,
   "testing (2, 0, -1)";

# some other test cases
is smallest-positive-number((1, 2, 0)),      3,
   "testing (1, 2, 0)";
is smallest-positive-number((-8, -7, -6)),   1,
   "testing (-8, -7, -6)";
is smallest-positive-number((3, 4, -1, 1)),  2,
   "testing (3, 4, -1, 1)";
is smallest-positive-number((2, 3, 7, 6, 8, -1, -10, 15)), 1,
   "testing (2, 3, 7, 6, 8, -1, -10, 15)";

done-testing;

#
#
# SUBROUTINE

sub smallest-positive-number(@n where .all ~~ Int) {

    my @positive-numbers = @n.sort.grep: { $_ > 0 };
    return 1 unless @positive-numbers.elems;

    my $i = 0;
    (1 .. @positive-numbers.tail).map: -> $n {
        return $n if $n < @positive-numbers[$i++]
    };

    return ++@positive-numbers.tail;
}
