#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # ∅ ≡ ∩ ≢
use Test;

=begin comment
186-1: Zip List         Submitted by: Mohammad S Anwar
You are given two lists, @a and @b, of same size.  Create a subroutine
sub zip(@a, @b) that merges the two lists as shown in the example below.

Example
Input:  @a = qw/1 2 3/; @b = qw/a b c/;
Output: zip(@a, @b) should return qw/1 a 2 b 3 c/;
        zip(@b, @a) should return qw/a 1 b 2 c 3/;
=end comment

sub zip( @l, @r --> List ) { List( [Z]  @l, @r); }

constant TEST=True;
if TEST {
    my @Test = {  l => <1 2 3>,
                  r => <a b c >,
                  lr => < 1 a 2 b 3 c>,
                  rl => < a 1 b 2 c 3>, },;

    plan 2 × @Test.elems;

    for @Test -> %t {
        is zip( %t<l>, %t<r>), %t<lr>, 'l r ';
        is zip( %t<r>, %t<l>), %t<rl>, 'r l ';
    }
    done-testing;
}

