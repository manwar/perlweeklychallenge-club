#!/usr/bin/env raku
use Test;
use Benchy;

is reverse-pairs(1,3,2,3,1), 2;
is reverse-pairs(2,4,3,5,1), 3;

benchmark();

sub reverse-pairs(*@a)
{
    my $bag = @a.BagHash;

    sum gather for @a -> $a
    { 
        $bag{$a}--;

        for $bag.keys -> $k
        {
            take $bag{$k} if $a > $k + $k 
        }
    }
}

sub reverse-pairs-slow(*@a)
{
    + grep { .[0] > .[1] * 2 }, @a.combinations(2)
}

sub benchmark
{
    my @a = (1..9).roll(2500);

    b 5, { reverse-pairs-slow(@a) }, { reverse-pairs(@a) }

    # Old:  54.254473421s
    # New:  1.151968905s
    # NEW version is 47.10x faster
}
