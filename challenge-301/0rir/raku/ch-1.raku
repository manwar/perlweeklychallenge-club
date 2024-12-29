#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
301-1: Largest Number           Submitted by: Mohammad Sajid Anwar

You are given a list of positive integers, @ints.

Write a script to arrange all the elements in the given list such that they form the largest number and return it.
Example 1

Input: @ints = (20, 3)
Output: 320

Example 2

Input: @ints = (3, 30, 34, 5, 9)
Output: 9534330

=end comment

=reuse
Reuse of most of challenge-217/0rir/raku/ch-2.raku, with a little
refactoring and commenting.
=reuse


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
;

my @Test =
    (3, 30, 34, 5, 9),      9534330,
    (20, 3),                    320,
    (1, 23),                    231,
    (10, 3, 2),                3210,
    (31, 2, 4, 10),          431210,
    (5, 11, 4, 1, 2),        542111,
    (1, 10),                    110,
;

plan @Test-cmp + @Test;

# cat-cmp -- compare Ints for greatest significance for creating largest
# number by concatenation.  Compare each digit, L to R, if one runs out of
# digits, continue with its R-most digit.
sub cat-cmp( Any:D(Int) $a, Any:D(Int) $b ) {
    my @a = $a.comb.Array;
    my @b = $b.comb.Array;
    my $span = @a.elems min @b.elems;
    for ^$span -> $i {
        my $o = @a[$i] <=> @b[$i];
        if ? $o { return $o }
    }

    given @a <=> @b {
        when Same { return Same }
        when More {
           return cat-cmp @a[$span..*].join, @b.join;
        }
        when Less {
           return cat-cmp @a.join, @b[$span..*].join;
        }
    }
}

sub max-number( @a -->Int) { (@a.sort: { cat-cmp $^b, $^a } ).join.Int }

sub task( @a -->Int) { max-number( @a) }

# check by brute force
sub control( Int $me, @a --> Int) {
    for @a.permutations -> @p {
        my $candi = (@p».Str).join.Int;
        return False if $candi > $me;
  }
  True;
}

for @Test-cmp -> @in, $exp is rw {
    is cat-cmp( @in[0], @in[1]), $exp, "$exp <-- cat-cmp @in[0] @in[1]";
    $exp = ( $exp × -1).Order;
    is cat-cmp( @in[1], @in[0]), $exp, "$exp <-- cat-cmp @in[1] @in[0]";
}
for @Test -> @in, $exp {
    my $got = task( @in);
    is $got, $exp, "expect: $exp <- @in[]";
    ok ?control($got, @in), "check";
}
done-testing;

my @list = (5, 12, 4, 1, 2);
say "\nInput: @int = @list[]\nOutput: ", max-number( @list);
