#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
222-2: Last Member                  Submitted by: Mohammad S Anwar
Given rules and an array of positive integers, @ints, find the last member
if found otherwise return 0 by applying the follwoing rules.  Each turn
pick 2 biggest members (x, y) then decide based on the following conditions,
continue this until you are left with 1 member or none.

a) if x == y then remove both members

b) if x != y then remove both members and add new member (y-x)


Example 1:
Input: @ints = (2, 7, 4, 1, 8, 1)
Output: 1

Step 1: pick 7 and 8, we remove both and add new member 1 => (2, 4, 1, 1, 1).
Step 2: pick 2 and 4, we remove both and add new member 2 => (2, 1, 1, 1).
Step 3: pick 2 and 1, we remove both and add new member 1 => (1, 1, 1).
Step 4: pick 1 and 1, we remove both => (1).

Example 2:
Input: @ints = (1)
Output: 1

Example 3:
Input: @ints = (1, 1)
Output: 0
=end comment

my @Test =
    (),                          0,
    (1,),                        1,
    (1,1),                       0,
    (1,1,1),                     1,
    [∞, ∞],                      0,
    (2,1,1),                     0,
    (2,1,1,1),                   1,
    (5,1),                       1,
    (5,5,5,5,),                  0,
    (5,5,5,5,5,),                1,
    (6,6,5,5,5,),                1,
    (2, 7, 4, 1, 8, 1),          1,
    [2, 2, 2, 2, 2, 2, 1],       1,
    [2, 2, 2, 2, 2, 2, 2, 1],    1,
    [10, 15, 4],                 1,
    [10, 15, 2],                 1,
    [20, 15, 2],                 1,
;

plan @Test ÷ 2;

sub func( @b )  {
    my $b = BagHash.new: @b;

    loop {
            # done?
        return 0   if $b.total == 0;
        return 1   if $b.total == 1;

            # elim even count max
        if $b.max.value %% 2 {
            $b{$b.max.key} = 0;
            next;
        }

            # resolve singular max
        $b{$b.max.key} = 1;
        return 1    if $b.total == 1;
        my $super-max = $b.max.key;
        $b.remove: $super-max;
        my $max = $b.max.key;
        $b.remove: $max;
        $b.add: $super-max - $max;
    }
}

for @Test ->  @in, $exp {
    is func(@in), $exp, "$exp <- @in.sort.reverse()";
}
done-testing;

my @int = ( 20, 70, 70, 40, 10, 80 ).sort;
say "\n\nInput: @ints = @int[]\nOutput: ", func(@int);

