#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
May be edited.
393-1: Pythagoras Multiplied        Submitted by: Ulrich Rieke

You are given a positive integer n.  Find the number of all positive
integer triplets (a, b, c) so that a^2 + b^2 = c^2 and a, b and c are
integers <= n.

Example 1

(3,4,5),(4,3,5)
￼
Example 3
Input: $n = 1
Output: 0
￼
Example 4
Input: $n = 15
Output: 8
￼
Example 5
Input: $n = 30
Output: 22

=end comment

my @Test =
 #  in          exp
    20,         12,
     7,          2,
     1,          0,
    15,          8,
    30,         22,
;
plan @Test ÷ 2;

only task( Int \n where * > 0) {
    my $ret = 0;
    for [X] [1...n] xx 3 -> (\a, \b, \c) {
        if  c > b > a   and   a² + b² == c²   {
            ++$ret;
        }
    }
    $ret ×= 2; 
}

for @Test -> $in, $exp  {
    is task( $in), $exp, "$exp <- $in";
}

done-testing;

my $n = 60;

say qq{\nInput: \$n = $n\nOutput: }, task $n;


