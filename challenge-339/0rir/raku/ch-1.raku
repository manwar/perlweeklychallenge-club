#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.e.PREVIEW;
use Test;

=begin comment
Edited for space.
339-1: Max Diff         Submitted by: Mohammad Sajid Anwar
You are given an array of integers having four or more elements.
Write a script to find two pairs of numbers from this list (four numbers total) so that the difference between their products is as large as possible.
In the end return the max difference.
With Two pairs (a, b) and (c, d), the product difference is (a * b) - (c * d).
Example 1
Input: @ints = (5, 9, 3, 4, 6)
Output: 42
Pair 1: (9, 6)
Pair 2: (3, 4)
Product Diff: (9 * 6) - (3 * 4) => 54 - 12 => 42
Example 2
Input: @ints = (1, -2, 3, -4)
Output: 10
Example 3
Input: @ints = (-3, -1, -2, -4)
Output: 10
Example 4
Input: @ints = (10, 2, 0, 5, 1)
Output: 50
Example 5
Input: @ints = (7, 8, 9, 10, 10)
Output: 44
=end comment

my @Test =
    (5, 9, 3, 4, 6),        42,
    (1, -2, 3, -4),         10,
    (-3, -1, -2, -4),       10,
    (10, 2, 0, 5, 1),       50,
    (-10, -2, 0, -5, -1),   50,
    (7, 8, 9, 10, 10),      44,

    (0,0,0,0),              0,
    (0,0,0,0,0,0),          0,
    (0,1,2,3),              6,
    (-3,-2,-1,0),           6,
    (-1,0,0,2),             2,
    (-1,0,1,2),             2,
    (-2,-1,0,1,2),          4,
    (-10,-2,0,0,0,2,10),  100,
    (-10,-2,  0,0,2,10),  100,
    (-10,-2,    0,2,10),  100,
    (-10,-2,      2,10),   96,
    (   -10, -2, -1, 0, 1_000, 10_000, 100_000), 1_000_010_000,
    (-1_000, -2, -1, 0, 1_000, 10_000, 100_000), 1_001_000_000,
    (-1_000, -10, -9, -8, -7, -6, -5, -4, -3, -2, -1, 0, 1,2,3,4,5,6,7
            ,8,9,10,11,12,13,14,15,16,17,18,19,20,
                1_000, 10_000, 100_000),         1_001_000_000,
;

plan +@Test ÷ 2;

sub task( @ary where +* ≥ 4 ) {

    # Solve single set of four.
    return four( @ary )  if +@ary == 4;

    my @a = @ary.sort.Array;

    #  Solve one sided, relative to zero, data.
    if @a[0] ≥ 0 or @a[*-1] ≤ 0 {
        return  abs @a[0] × @a[1]  -  @a[*-1] × @a[*-2];
    }

   #  Classify by sign.
    my ( $i, $j);
    $i = @a.first( :k, :end, so * < 0);
    $j = @a.first( :k,       so * > 0);
    my @neg = @a[ 0 .. $i];
    my @zed = @a[$i^..^$j];
    my @pos = @a[$j ..^@a];

    # Reduce the working set.   More analysis may allow further reduction.
    my @shrunk =  (  flat
                    @neg > 3 ?? @neg[^3] !! @neg,
                    @zed > 2 ?? @zed[^2] !! @zed,
                    @pos > 3 ?? @pos[*-3 .. *-1] !! @pos,
                ).Array.combinations( 4);

    my $ret = -∞;

    for @shrunk -> @f {
        $ret max= four( @f)
    }
    return $ret;
                            sub four( @in -->Int) { # XXX How to destructure?
                                my ( $a, $b, $c, $d) = @in;
                                max abs( $a × $b - $c × $d),
                                    abs( $a × $c - $b × $d),
                                    abs( $a × $d - $c × $b);
                            }
}

sub mark-anderson(@a)
{
    my %c := { -1 => [], 0 => [], 1 => [] }
    @a.classify(*.sign, :into(%c));
    %c<-1> = %c<-1>.sort.Array;
    %c<1>  = %c<1> .sort.Array;

    if %c<0> >= @a.end { return 0 }
    if none(%c<-1 0>)  { return ([*] %c<1> .tail(2)) - ([*] %c<1> .head(2)) }
    if none(%c<1 0>)   { return ([*] %c<-1>.head(2)) - ([*] %c<-1>.tail(2)) }

    return .max given gather
    {
        if all(%c<1> >= 3, %c<-1> >= 1)
        {
            take ([*] %c<1>[*-2,*-1]) - ([*] %c<-1>[0], %c<1>[*-3]);
            take ([*] %c<1>[*-3,*-2]) - ([*] %c<-1>[0], %c<1>[*-1])
        }

        if all(%c<-1> >= 3, %c<1> >= 1)
        {
            take ([*] %c<-1>[0,1]) - ([*] %c<-1>[2], %c<1>[*-1]);
            take ([*] %c<-1>[1,2]) - ([*] %c<-1>[0], %c<1>[*-1])
        }

        if all(all(%c<-1 1>) >= 2, none(%c<0>))
        {
            take (%c<-1>.tail * %c<1>.head) - (%c<-1>.head * %c<1>.tail)
        }

        if all(%c<-1 0 1>) >= 1
        {
            take -([*] %c<-1>.head, %c<1>.tail)
        }

        if all(%c<1> >= 2, %c<0> >= 1)
        {
            take [*] %c<1>.tail(2)
        }

        if all(%c<-1> >= 2, %c<0> >= 1)
        {
            take [*] %c<-1>.head(2)
        }

        if %c<-1> == 2
        {
            take ([*] %c<-1>.head(2)) - ([*] %c<1>.head(2))
        }

        if %c<1> == 2
        {
            take ([*] %c<1>.tail(2)) - ([*] %c<-1>.tail(2))
        }
    }
}

sub feng-chang( @ints ) {
    #put
    @ints.combinations(4).map(-> @a { (^4).combinations(2).map(-> @b { abs(([*] @a[@b]) - [*] @a[(^4 (-) @b).keys]) }) }).flat.max;
}

for @Test -> @in, $exp {
    is task( @in), $exp, "{$exp // $exp.^name()} <- @in.raku()";
#   is feng-chang( @in), $exp, "{$exp // $exp.^name()} <- @in.raku()";
#   is mark-anderson( @in), $exp, "{$exp // $exp.^name()} <- @in.raku()";
}
done-testing;
my @int = (10, 2, 0, 5, 1);

say qq{\nInput: @ints = @int[]\nOutput: }, task @int;
