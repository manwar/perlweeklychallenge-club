#!/usr/bin/env raku
use Test;
use Adverb::Eject;

is-deeply arithmetic-subsequence([9,4,7,2,10]),       [4,7,10];
is-deeply arithmetic-subsequence([3,6,9,12]),         [3,6,9,12];
is-deeply arithmetic-subsequence([20,1,15,3,10,5,8]), [20,15,10,5];

sub arithmetic-subsequence(@a)
{
    for @a.keys.combinations
    {
        my @b = @a;
        @b[$_]:eject;
        return @b if @b ~~ (@b.head(2)...*).head(@b)
    }
}
