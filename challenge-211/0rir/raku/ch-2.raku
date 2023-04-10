#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
211-2: Split Same Average              Submitted by: Mohammad S Anwar
Given an array of integers, find out if the array can be split into two
separate arrays whose averages are the same.

Example 1:
Input: @nums = (1, 2, 3, 4, 5, 6, 7, 8)
Output: true
We can split the given array into (1, 4, 5, 8) and (2, 3, 6, 7).
The average of the two arrays are the same i.e. 4.5.

Example 2:
Input: @list = (1, 3)
Output: false
=end comment

my @Test =
        # shorts -- atomic
    [ ],                        False,
    [ 1],                       False,
        # given examples
    [ 1,3],                     False,
    [ 2,3,6,7,   1,4,5,8],      True,
        # more
    [ 11           xx 111],     True,
    [ 0,0,0,0,0],               True,
    [ 1,1],                     True,
    [ 1,2],                     False,
    [ 1,2,4],                   False,
    [ 2,2,3],                   False,
    [ 1,-1],                    False,
    [ 1,14,15],                 False,
    [ 1,14,          0,15],     True,
    [ 0,0,1,14,15],             False,
    [ 0,1,14,      0,0,15],     True,
    [ 1,2,3,12,13,14,15],       False,
    [ 0,7,    1,2,3,4,5,6],     True,
    [ 0,1,1,2,3,4,5,6,7],       False,
    [ 1,4,            2,3],     True,
    [ 2,          0,1,3,4],     True,
    [ 1,4,5,7,  0,2,3,6,8],     True,
    [ -2,         -1,-1,0],     True,
    [ -3,-2,-1,1],              False,
    [ -3…0],                    True,
    [ -3…1],                    True,
    [ -1,0,2,6,7,  1,1,3,4,5],  True,
    [ -1,-1,2,6,7, 0,1,3,4,5],  True,
    [ -1,1,2,3,4,5,6,7],        False,
    [ -10…10],                  True,
    [ -9…10],                   True,
    [ 1…12],                    True,
    [ 0…12],                    True,
    [ -2…1],                    True,
    [ -4…4],                    True,
;

# return True if so 'subset.elems × other.sum == subset.sum × other.elems'
# is found, else False.
multi same-average-parts2( @in where *.elems ≤ 1 -->Bool ){ False }
multi same-average-parts2( @in -->Bool){

    my Int $total = [+] @in;

    my $prev;
    for 1..(@in.elems div 2) -> $a-elems {
        for @in.combinations( $a-elems).sort -> $a {
            my $b-val = $a-elems × ($total - [+] $a);

            if $b-val == ([+] $a) × ( @in.elems - $a-elems) {
                return True;
    }   }   }
    return False;
}

plan @Test/2;

for @Test ->  @t, $exp {
    is same-average-parts2( @t), $exp,  "$exp <- @t[]";
}
done-testing;

my $ints = @Test[*-2];
say "\nInput: \$ints = $ints[]"
   ,"\nOutput: &same-average-parts2($ints)";

exit;
