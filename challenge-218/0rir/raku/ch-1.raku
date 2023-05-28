#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6.d;
use lib $?FILE.IO.parent(2).add("lib");
use Test;

=begin comment
218-1: Maximum Product          Submitted by: Mohammad S Anwar
Given a list of 3 or more integers, find the 3 integers whose product
is the maximum and return it.

Example 1
Input: @list = (3, 1, 2)
Output: 6

1 x 2 x 3 => 6
Example 2
Input: @list = (4, 1, 3, 2)
Output: 24

2 x 3 x 4 => 24
Example 3
Input: @list = (-1, 0, 1, 3, 1)
Output: 3

1 x 1 x 3 => 3
Example 4
Input: @list = (-8, 2, -9, 0, -4, 3)
Output: 216

-9 × -8 × 3 => 216

=end comment

my @Test =
    # in                            exp
    (3, 1, 2),                            6,    # given
    (4, 1, 3, 2),                        24,
    (-8, 2, -9, 0, -4, 3),              216,
    (-1, 0, 1, 3, 1),                     3,

#   (-3, -2, -1,  0),                     0,

    ( 2, 3, 5),                          30,    # three elems

    ( 0,  1,  2,  3),                     6,    # quads
    ( 1,  2,  3,  4),                    24,
    (-3, -2, -1,  0),                     0,
    (-4, -3, -2, -1),                    -6,
    (-1,  1,  2,  3),                     6,
    (-1, -1, -2,  3),                     6,
    (-1, -1,  2,  3),                     3,
    (-3, -2,  3,  3),                    18,
    (-3, -3,  3,  3),                    27,

    ( 0,  1,  2,  3,  4),                24,    # all pos
    ( 1,  2,  3,  4,  5),                60,
    (-4, -3, -2, -1,  0),                 0,    # max zed
    (-5, -4, -3, -2, -1),                -6,    # all neg
    (-2, 0,  1,  2,   3),                 6,    # 1 neg
    (-2,  1,  2,  3,  4),                24,    # 1 neg
    (-2, -3, -1, -1,  4),                24,    # 1 pos

    (-1, -1,  2,  3,  4),                24,    # 2 neg
    (-3, -2,  1,  3,  3),                18,
    (-3, -2,  3,  3,  3),                27,
    (-3, -2,  1,  3,  3,  3),            27,

    (-2, -1, -1,  3,  4),                8,    # 2 pos
    (-3, -2, -1,  3,  3),               18,
    (-3, -2, -1, -1,  1,  2),           12,
    (-3, -2,  1,  3,  3,  3),           3³,

    (-9, -2, -2,  2,  3,  6),           108,   # default
    (-8, -4, -2,  2,  4,  9),           288,
    (-8, -4, -2,  5,  6,  9),           288,
    (-8, -4, -2,  5,  7,  9),           315,
    (-8, -5, -2,  5,  7,  9),           360,
    ;

plan @Test ÷ 2 + 1 + 2_005_000;


multi max3prod( @a where *.elems  < 3) { die( 'oospec') }
#multi max3prod( @a where *.elems == 3) { [×] @a }                   # triad
#multi max3prod( @a where *.elems == 4) {                            # quad
#            @a.combinations(3).map( {[*] $_} ).max }
multi max3prod( @a ) {
    multi func {…}
    return func @a.sort;

    # more than 4 elems
#   multi func( @a where *[*-1] == 0)  { 0 }                        # max0 
    multi func( @a where 0 ≤ *[0])     { [×] @a[*-3..*-1] }         # all pos
    multi func( @a where *[*-1] < 0)   { [×] @a[*-3..*-1] }         # all neg
    # mixed signs
#   multi func( @a where $_[0] < 0 < $_[1] ) { [×] @a[*-3..*-1] }   # 1 neg
#multi func( @a where $_[*-2] < 0 < $_[*-1]) { [×] @a[0,1,*-1] } # 1 pos
#   multi func( @a where $_[*-3] < 0 < $_[*-2]) {                   # 2 pos
#           max ([×] @a[0,1,*-1]), ([×] @a[*-3..*-1]); }
#   multi func( @a where $_[1] < 0 < $_[2] ) {                      # 2 neg
#           max ([×] @a[0,1,*-1]), ([×] @a[*-3..*-1]); }
    multi func( @a )    {                                           # default
            max ([×] @a[0,1,*-1]), ([×] @a[*-3..*-1]); }
}

for @Test -> @in, $exp {
    is max3prod(@in), $exp, "$exp\t<- @in.sort()";
}
srand(104571);
hyper for 1..2_005_000 {
    my @t;
    for  1..4 + (^5).pick -> $l {
        for (^20).pick - 10 -> $r {
            @t.push: $r;
        }
    }
    my $res = @t.combinations(3).map( {[*] $_} ).max;
    is max3prod(@t), $res, "$res\t<- @t.sort()";
}

dies-ok { max3prod( (1,2)) }, "(1,2) dies-ok";
done-testing;

my $list = (-8, 2, -9, 0, -4, 3);
say "\nInput: @list = @$list[]\nOutput: &max3prod(@$list).sort()";


exit;

