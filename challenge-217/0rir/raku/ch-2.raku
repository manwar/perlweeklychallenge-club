#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
217-2: Max Number       Submitted by: Mohammad S Anwar

Given a list of positive integers, concatenate the integers to form the highest possible value.

Example 1:
Input: @list = (1, 23)
Output: 231
Example 2:
Input: @list = (10, 3, 2)
Output: 3210
Example 3:
Input: @list = (31, 2, 4, 10)
Output: 431210
Example 4:
Input: @list = (5, 11, 4, 1, 2)
Output: 542111
Example 5:
Input: @list = (1, 10)
Output: 110
=end comment

my @Test-cmp =
    (1      , 1  ),     Same,
    (12     , 12 ),     Same,
    (123    , 123),     Same,
    (1231234, 123),     More,
    (123133 , 123),     More,
    (12313  , 123),     More,
    (123111 , 123),     Less,
    (12311  , 123),     Less,
    (1231   , 123),     Less,
    (1      , 23 ),     Less,
    (10     , 3  ),     Less,
    (31     , 2  ),     More,
    (2      , 4  ),     Less,
    (4      , 10 ),     More,
    (5      , 11 ),     More,
    (11     , 4  ),     Less,
    (1      , 10 ),     More,
    (Int    , Int),     Order,

;

my @Test =
    (1, 23),                   231,
    (10, 3, 2),               3210,
    (31, 2, 4, 10),         431210,
    (5, 11, 4, 1, 2),       542111,
    (1, 10),                   110,
;

plan  @Test-cmp + @Test/2;

sub cat-cmp( Any:D $a, Any:D $b ) {
    my @a = $a.comb.Array;
    my @b = $b.comb.Array;
    my $span = (@a.elems, @b.elems).min;
    for ^$span -> $i  {
        my $o =  @a[$i] <=> @b[$i];
        if ? $o { return $o }
    }

    given +@a <=> +@b {
        when Same { return Same }
        when More {
           return cat-cmp @a[$span..*].join, @b.join;
        }
        when Less {
           return cat-cmp @a.join, @b[$span..*].join;
        }
    }
}

sub max-number(  @a -->Int) {
        (@a.sort: { cat-cmp $^b.Int, $^a.Int } ).join.Int;
}

for @Test-cmp -> @in, $exp is rw {
    is cat-cmp( @in[0], @in[1]), $exp, "$exp <-- cat-cmp @in[0] @in[1]";
    $exp = ( $exp × -1).Order;
    is cat-cmp( @in[1], @in[0]), $exp, "$exp <-- cat-cmp @in[1] @in[0]";

}
for @Test -> @in, $exp {
    is max-number(@in), $exp, "$exp <-- @in.raku()";
}
done-testing;

my @list = (5, 11, 4, 1, 2);
say "\nInput: @list = @list[]\nOutput: ", max-number( @list);
exit;

