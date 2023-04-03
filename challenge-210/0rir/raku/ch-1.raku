#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
201-1: Kill and Win         Submitted by: Mohammad S Anwar
Given a list of integers get the maximum points. You are allowed to take out
(kill) any integer and remove from the list. However if you do that then all
integers exactly one-less or one-more would also be removed.
Find out the total of integers removed.

Example 1
Input: @int = (2, 3, 1)
Output: 6

First we delete 2 and that would also delete 1 and 3. So the maximum points
we get is 6.
Example 2
Input: @int = (1, 1, 2, 2, 2, 3)
Output: 11

First we delete 2 and that would also delete both the 1's and the 3. Now we have (2, 2).
Then we delete another 2 and followed by the third deletion of 2. So the maximum points we get is 11.

=end comment

my @Test =
    [<2 3 1                              >],          6,
    [<6 7 8      10                      >],         21,
   
    [<100                                >],         100,
    [<1 1 2 2 2 3 3                      >],          14,
    [<1 1 1 1 1 1 2                      >],           8,
    [<2 1 1 1 1 1 1                      >],           8,
    [<1 1 2 2 2 3 3 4 4 4 6 7  100       >],         100,
    [<1 1   2 2 2 3 3 4 4 4    5 6 7     >],          24,
    [<1 1      2 2 2 3 4       5 8       >],          13,
;

sub sum-all-occurances-me-precessor-successor ( Int @a --> Int)  {

    my Int %h{Int};
    my Int %s{Int};

    for @a -> $val { %h{$val} += $val }
    for %h.keys -> $k {
        %s{$k} = %h{$k} + (%h{$k -1} // 0) + ( %h{$k+1} // 0);
    }
    %s.values.max;
}

plan @Test/2;

for @Test -> @proto-in, $exp {
    my Int @in = @proto-in.map( *.Int);
    is sum-all-occurances-me-precessor-successor(@in), $exp, '';
}
done-testing;

my Int @int = [<1 1   2 2 2 3 3 4 4 4   5 6 7>].map( *.Int);

say "\nInput: @int = @int[]";
say "Output: &sum-all-occurances-me-precessor-successor(@int)";

exit;
