#!/usr/bin/env raku
use Test;

is-deeply armstrong(10, 1000), (0,1,2,3,4,5,6,7,8,9,153,370,371,407);
is-deeply armstrong( 7, 1000), (0,1,2,3,4,5,6,10,25,32,45,133,134,152,250);
is-deeply armstrong(16, 1000), (0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,342,371,520,584,645);

sub armstrong($base, $limit)
{
    ^$limit .grep:
    {
        my $b = .base($base);
        $_ == sum $b.comb>>.parse-base($base) >>**>> $b.chars
    }
}
