#!/usr/bin/env raku
use Test;

is-deeply duplicate-and-missing(1,2,2,4),     (2,3);
is-deeply duplicate-and-missing(1,2,3,4),        -1;
is-deeply duplicate-and-missing(1,2,3,3),     (3,4);
is-deeply duplicate-and-missing(4,5,6,7,7,8), (7,9);
is-deeply duplicate-and-missing(4,5,6,7,7,9), (7,8);
is-deeply duplicate-and-missing(4,5,6,6,7,9), (6,8);
is-deeply duplicate-and-missing(4,6,6,7,8,9), (6,5);

use Algorithm::Diff;
is-deeply diff-module(1,2,2,4),     (2,3);
is-deeply diff-module(1,2,3,4),        -1;
is-deeply diff-module(1,2,3,3),     (3,4);
is-deeply diff-module(4,5,6,7,7,8), (7,9);
is-deeply diff-module(4,5,6,7,7,9), (7,8);
is-deeply diff-module(4,5,6,6,7,9), (6,8);
is-deeply diff-module(4,6,6,7,8,9), (6,5);

sub duplicate-and-missing(*@nums)
{
    given @nums
    {
        my @range = .head .. .head + .end;
        flat .repeated, keys @range (-) $_ or -1  
    }
}

sub diff-module(*@nums)
{
    my @range = .head .. .head + .end given @nums;
    my $r = diff(@nums, @range).comb(/\d+/)[1,3];
    $r.all.defined ?? $r>>.Int !! -1
}
