#!/usr/bin/env raku
use Adverb::Eject;
use Test;

is-deeply target-array([0,1,2,3,4], [0,1,2,2,1]), [0,4,1,3,2];
is-deeply target-array([1,2,3,4,0], [0,1,2,3,0]), [0,1,2,3,4];
is-deeply target-array([1],         [0]),         [1,];
is-deeply target-array([5,6,7,8],   [1,1,0,0]),   [8,7,6,5];
is-deeply target-array([5,6,7,8],   [2,1,0,1]),   [7,8,6,5];

sub target-array(@s, @i)
{
    my @a = Any xx @i;

    for @i Z @s -> ($i,$s)
    {
        @a = |@a[^$i], $s, |@a[$i..*];
        my $k = @a[$i..*].first({ not .defined }, :k) + @a[^$i];   
        @a[$k]:eject
    }

    return @a
}
