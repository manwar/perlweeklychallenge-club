#!/usr/bin/env raku
use Test;

is semi-ordered(2,1,4,3),   2;
is semi-ordered(2,4,1,3),   3;
is semi-ordered(1,3,2,4,5), 0;

sub semi-ordered(+@a)
{
    given @a
    {
        my $head = .first(1, :k);
        my $tail = .first(.elems, :k);
        $head < $tail ?? $head + .end - $tail !! $head + .end - $tail - 1
    }
}
