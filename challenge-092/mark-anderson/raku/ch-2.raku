#!/usr/bin/env raku

use Test;
plan 5;

is-deeply insert-interval(
   (2,6), [(1,4), (8,10)]),        [(1,6), (8,10)],         "Example 1";
is-deeply insert-interval(
   (5,8), [(1,2), (3,7), (8,10)]), [(1,2), (3,10)],         "Example 2";
is-deeply insert-interval(
   (10,11), [(1,5), (7,9)]),       [(1,5), (7,9), (10,11)], "Example 3";
is-deeply insert-interval(
   (1,2), [(3,4), (7,8)]),         [(1,2), (3,4), (7,8)],   "First";
is-deeply insert-interval(
   (1,9), [(2,3), (7,8)]),         [(1,9),],                "Around";

sub insert-interval($N is copy, @S) {
    my @result;

    return [$N, |@S] if $N[1] < @S[0;0];

    @result.push: @S.shift while @S and @S[0;1] < $N[0];

    my $head = min @S[0;0], $N[0];

    @S.shift while @S[1] and @S[1;0] <= $N[1];

    my $tail = max @S[0;1], $N[1];

    @result.append: $($head, $tail), |@S[1..*];
}
