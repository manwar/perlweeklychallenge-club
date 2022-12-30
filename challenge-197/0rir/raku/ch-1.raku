#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅ ≡ ∩ ≢ ∈ «␤»
use v6.d;
use Test;

=begin comment
197-1                           Submitted by: Mohammad S Anwar
Given a list of integers, @list, move all zeroes, if existing, to the end
while maintaining the relative order of non-zero elements.

Example 1
Input:  @list = (1, 0, 3, 0, 0, 5)
Output: (1, 3, 5, 0, 0, 0)
=end comment

sub round-posi( @a --> Array) {
    @a.grep(* !~~ 0).Array.append( @a.grep(* ~~ 0))
}

multi MAIN () {
    my @Test =
        (1, 0, 3, 0, 0, 5) => ( 1,3,5,0,0,0),
        (0, 1, 0, 2, 0) => ( 1,2,0,0,0),
        (0,4) => (4,0),
        (1,0) => (1,0),
        (1,4) => (1,4),
        (1, 2, 3) => (1,2,3),
        (1, 0, 3) => (1,3,0),
        (1, 2, 0) => (1,2,0),
        (0, 2, 3) => (2,3,0),
        (1, 0, 0) => (1,0,0),
        (0, 2, 0) => (2,0,0),
        (0, 0, 3) => (3,0,0),
        (0,7) => (7,0),
        (7,0) => (7,0),
        (7,) => (7,),
        (0,) => (0,),
        () => (),
    ;
    plan +@Test;
    for @Test -> $p {
        is  round-posi( $p.key), $p.value, " $p.key()";
    }
    done-testing;

    my @list = (1,0,3,0,0,5);
    say "\nInput:  \@list = @list.raku()\n"
      ~ "Output:         ", round-posi( @list).raku;
}
