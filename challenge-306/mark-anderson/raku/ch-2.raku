#!/usr/bin/env raku
use Test;

is last-element(3,8,5,2,9,2), 1;
is last-element(3,2,5),       0;

sub last-element(+@ints)
{
    my $bag = @ints.BagHash;
    
    while $bag.elems > 1
    {
        my $a = $bag.max.key;
        my $even = $bag{$a} %% 2;
    
        $bag{$a} = 0;

        unless $even
        {
            my $b = $bag.max.key;
            $bag{$b}--;
            $bag{$a-$b}++
        }
    }

    $bag.values.head %% 2 ?? 0 !! $bag.keys.head
}
