#!/usr/bin/env raku
use Test;

is-deeply distribute-elements(2,1,3,4,5), [2,3,4,5,1];
is-deeply distribute-elements(3,2,4),     [3,4,2];
is-deeply distribute-elements(5,4,3,8),   [5,3,4,8];

# I was going to try something like this
#
#    while @ints
#    {
#        my $k = @ints.first(* < @arr2.tail, :k) // @ints.end;
#        @arr1.append: @ints.splice(0, $k+1);
#        :(@arr1, @arr2) := (@arr2, @arr1)
#    }
#
# but for some reason I get an error swapping inside the while loop.
# Swapping the arrays works outside of the loop. 
# https://rakudoweekly.blog/2022/06/20/2022-25-we-will-raku/      

sub distribute-elements(*@ints)
{
    my @arr1 = @ints.shift;
    my @arr2 = @ints.shift;

    while @ints
    {
        if @arr1.tail > @arr2.tail
        {
            my $k = @ints.first(* < @arr2.tail, :k) // @ints.end;
            @arr1.append: @ints.splice(0, $k+1)
        }

        else
        {
            my $k = @ints.first(* < @arr1.tail, :k) // @ints.end;
            @arr2.append: @ints.splice(0, $k+1)
        }
    }   

    @arr1.append: @arr2
}
