#!/usr/bin/env raku
use Test;
use Benchy;

is floor-sum(2,5,9),          10;
is floor-sum(7 xx 7),         49;
is floor-sum(5,5,7,15,15,15), 40;

benchmark();

=begin comment

            ***** Explanation of floor-sum() *****

There's a sequence for the floor-sum of consecutive numbers where 
@a[0] >= @a.elems. That sequence is...
 
    0,1,3,6,10,15,21,28,36,45,55,66,78,91,105,120,136,153,171,190...*

and can be generated with...

    0,1, -> $_ { ++$ + .succ }...*

For example, if @a is [5,6,7] or [10,11,12] then the floor-sum of 
@a is (0,1, -> $_ { ++$ + .succ } ... *)[@a.elems] == 6;

Unfortunately I couldn't see a pattern for consecutive numbers where
@a[0] < @a.elems so I left out the (possible) optimization of 
consecutive streaks in the input 😭

So here's what I did...

This challenge involves summing floor quotients so we can ignore 
any pair where the dividend is less than the divisor since those  
will always be 0.

Another optimization is turning the array into a bag 

    @a = [5 5 7 15 15 15]
    $bag = @a.Bag # Bag(15(3) 5(2) 7)

and then generating the key combinations

    $bag.keys.sort.combinations(2) # ((5 7) (5 15) (7 15))

The keys are sorted so the head is less than the tail so we don't 
get any quotients == 0.

Next, we take the floor(tail / head) of each pair and multiply that with
$bag{ tail } * $bag{ head }. 

     map { .[1] div .[0] * $bag{.[1]} * $bag{.[0]} }, 
                           $bag.keys.sort.combinations(2) # (2 18 6)

For example, the pair (5 15) result would be  

    (15 div 5) * $bag{15} * $bag{5} # 18

which is equivalent to the un-optimized 
    
    (15 div 5) + (15 div 5) + (15 div 5) + (15 div 5) + (15 div 5) + (15 div 5) 

Now we need the pair results from (15 15 15), (5 5) and (7) which are

    (15 div 15) + (15 div 15) + (15 div 15) +
    (15 div 15) + (15 div 15) + (15 div 15) +
    (15 div 15) + (15 div 15) + (15 div 15) # 9

    (5 div 5) + (5 div 5) + (5 div 5) + (5 div 5) # 4

    (7 div 7) # 1

which are the squares of the $bag values

    $bag.values >>**>> 2 # (9 4 1)

Finally, we just have to sum the two lists 
   
    (2 + 18 + 6) + (9 + 4 + 1) # 40  

=end comment 

sub floor-sum(*@a where .all > 0)
{
    my $bag = @a.Bag;

    sum flat $bag.values >>**>> 2,
             map { .[1] div .[0] * $bag{.[1]} * $bag{.[0]} }, 
                                   $bag.keys.sort.combinations(2) 
}

sub floor-sum-slow(*@a where .all > 0)
{
    sum @a Xdiv @a
}    

sub benchmark
{
    my @a = (1..9).roll(2500);

    b 5,
    {
        say floor-sum-slow(@a), " slow"
    },

    {
        say floor-sum(@a), " fast"
    }

    # Old:  48.663255609s
    # New:  0.172294888s
    # NEW version is 282.44x faster
}
