#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6.d;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use Test;

=begin comment
223-2: Box Coins                   Submitted by: Mohammad S Anwar
Given an array representing box coins, @box, collect the maximum coins until
you took out all boxes. If we pick box[i] then we collect the coins $box[i-1] * $box[i] * $box[i+1]. If $box[i+1] or $box[i-1] is out of bound then treat it as 1 coin.

Example 1:
Input: @box = (3, 1, 5, 8)
Output: 167

Step 1: pick box [i=1] and collected coins 3 * 1 * 5 => 15.  Boxes available (3, 5, 8).
Step 2: pick box [i=1] and collected coins 3 * 5 * 8 => 120. Boxes available (3, 8).
Step 3: pick box [i=0] and collected coins 1 * 3 * 8 => 24.  Boxes available (8).
Step 4: pick box [i=0] and collected coins 1 * 8 * 1 => 8.   No boxes available.
Example 2:
Input: @box = (1, 5)
Output: 10

Step 1: pick box [i=0] and collected coins 1 * 1 * 5 => 5. Boxes available (5).
Step 2: pick box [i=0] and collected coins 1 * 5 * 1 => 5. No boxes available.
=end comment

my @Test =
    (1, 5),            10,
    (1, 5, 1),         15,
    (3, 1, 5, 8),     167,
    (0,),               0,
    (1,),               1,
    (0,1,0),            1,
    (1,2),              4,
    (0,1,2),            4,
    (0,1,0,0,2,0,0),    4,
    (1,5,1,5,1),       65,
    (1,5,1,8,1),      104,
;

plan @Test ÷ 2;

sub brute( @input where { .all > -1} -->Int) {
    my @in = @input.grep( * ≠ 0 );      # Ignore empty bags.kk
    my @order = (^@in).permutations;
    my $score = 0;
    for @order ->@o {
        my $s = score-a-perm @in, @o;
        $score < $s and $score = $s;
    }
    return $score;

                            #  not reached
    sub score-a-perm( @a, @perm -->Int) {
        my @wip = @a;
        my $score = 0;

        for @perm -> $i { $score += triplet( @perm, $i); }
        return $score;

            # not reached
            # find elem's triplet, destroy the elem, return triplet's value
        sub triplet( @perm, $i -->Int) {
            my $return = [×] L( $i), @wip[$i], R( $i);

say "@wip: @wip.raku() @perm @perm[] \$i $i  L: ", L($i)//"Nil", "  \@wip[$i]:  @wip[$i]   R: ", R($i) // 'Nil', " ->", $return;

            @wip[$i] = Any;
            return $return;
                # not reached
            sub L( $i ) {
                   my $k = @wip[ ^$i].first( *.defined, :k, :end);
                   return 1 without $k;
                   return @wip[$k];
            }
            sub R( $i) {
                   my $k = @wip[$i^..^@wip].first( *.defined, :k);
                   return 1 without $k;
                   return @wip[$i+$k+1];
            }
        }
    }
}

for @Test -> @in, $exp {
    is brute(@in), $exp, "$exp <- @in.raku()"
}

done-testing;
exit;

