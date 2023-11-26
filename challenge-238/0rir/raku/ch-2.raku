#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6.d;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use Test;

=begin comment
238-2: Persistence Sort         Submitted by: Mohammad S Anwar
Given an array of positive integers, sort the given array in increasing order
with respect to the count of steps required to obtain a single-digit number
by multiplying its digits recursively for each array element. If any two
numbers have the same count of steps, then print the smaller number first.  

Example 1
Input: @int = (15, 99, 1, 34)
Output: (1, 15, 34, 99)

15 => 1 x 5 => 5 (1 step)
99 => 9 x 9 => 81 => 8 x 1 => 8 (2 steps)
1  => 0 step
34 => 3 x 4 => 12 => 1 x 2 => 2 (2 steps)
Example 2
Input: @int = (50, 25, 33, 22)
Output: (22, 33, 50, 25)

50 => 5 x 0 => 0 (1 step)
25 => 2 x 5 => 10 => 1 x 0 => 0 (2 steps)
33 => 3 x 3 => 9 (1 step)
22 => 2 x 2 => 4 (1 step)
=end comment

my @Test =   #in             out
    (15, 99, 1, 34),        (1, 15, 34, 99),
    (50, 25, 33, 22),       (22, 33, 50, 25),
    (123457890, 123, 10,),  (10, 123, 123457890,),
;
my @Test-m-r = 
    1,                  0,
    10,                 1,
    123457890,          1,
    123,                1,
    1234,               2,
    2555,               2,
    1234578912345,      2,
    777,                4,
    999,                4,
;
plan ( @Test + @Test-m-r) ÷ 2;

subset Positive of Int where * ≥ 1;

# Return the count of successive multiplications of the digits of a number
# until the result is a single digit.
sub mult-reductions( Positive $n is copy --> Int ) {
    my $red;

    while $n > 9 {
        $n = [×] $n.comb;
        ++ $red;
    }
    $red // 0;
}

sub sort-by-mult-reds-then-value(@in ) {
    @in.sort( { .&mult-reductions, .Int} )
}

for @Test-m-r -> $in, $exp {
    is mult-reductions( $in.Int ), $exp, "$in to single digit takes $exp ops";
}

for @Test -> @in, @exp {
    my @result = @in.&sort-by-mult-reds-then-value;
    is @result, @exp, "@exp[] <- @in[]";
}

done-testing;

my @int = ( 1999,707, 50, 999, 777, 57, 9991);
say "\nInput: @int = @int[]\nOutput: &sort-by-mult-reds-then-value(@int)";

exit;

