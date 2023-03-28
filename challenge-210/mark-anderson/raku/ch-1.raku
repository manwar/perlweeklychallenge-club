#!/usr/bin/env raku
use Test;

is kill-and-win(2,3,1),                                    6; # choosing 2
is kill-and-win(1,1,2,2,2,3),                             11; # choosing 2
is kill-and-win(1,1,3,3,5,5),                             10; # choosing 5
is kill-and-win(4,4,4,4,7,8),                             16; # choosing 4
is kill-and-win(4,4,4,4,7,7,8),                           22; # choosing 7
is kill-and-win(8,6,3,3,8,1,9,3,1,4,5,2,5,4,5,4,7,3,3,5), 47; # choosing 4
is kill-and-win(2,6,1,1,6,5,6,3,4,9,8,3,3,2,3,2,3,3,7,9), 33; # choosing 7 or 8 
is kill-and-win(6,4,5,4,1,3,2,9,2,4,7,1,1,9,8,2,2,2,4,4), 33; # choosing 3 or 8

sub kill-and-win(*@ints)
{
    @ints.Bag
         .Array
         .push(@ints.max.succ => 0)
         .unshift(@ints.min.pred => 0)
         .sort
         .rotor(3 => -2)
         .map(&total)
         .max
} 

sub total(@a)
{
    my @slice = .[0] eq .[1]-1 eq .[2]-2 ?? (0,1,2) !! 
                .[0] eq .[1]-1           ?? (0,1)   !!   
                .[1] eq .[2]-1           ?? (1,2)   !! 
                                            (1)
                given @a.Map.keys.sort(+*);

    [+] .keys Z* .values given @a[@slice].Map
}
