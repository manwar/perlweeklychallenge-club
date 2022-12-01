#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅ ≡ ∩ ≢ ∈ «␤»
use v6.d;
use Test;

=begin comment
193-2: Odd String               Submitted by: Mohammad S Anwar
Given a list of strings of same length, @s, find the odd string in the given list. Use positional value of alphabet starting with 0, i.e. a = 0, b = 1, ... z = 25.
Find the difference array for each string as shown, then pick the odd one.

Example 1:
Input: @s = ("adc", "wzy", "abc")
Output: "abc"

Difference array for "adc" => [ d - a, c - d ] => [ 3 - 0, 2 - 3 ] => [ 3, -1 ]
Difference array for "wzy" => [ z - w, y - z ] => => [ 3, -1 ]
Difference array for "abc" => [ b - a, c - b ] => => [ 1, 1 ]
The difference array for "abc" is the odd one.

Example 2:
Input: @s = ("aaa", "bob", "ccc", "ddd")
Output: "bob"

Difference array for "aaa" => [ a - a, a - a ] => => [ 0, 0 ]
Difference array for "bob" => [ o - b, b - o ] => => [ 13, -13 ]
Difference array for "ccc" => [ c - c, c - c ] => => [ 0, 0 ]
Difference array for "ddd" => [ d - d, d - d ] => => [ 0, 0 ]
The difference array for "bob" is the odd one.
=end comment

=begin interpretation
Case distinction is ignored by assuming all input is lowercase as in the examples.
'Odd' has no clear definition and the examples are restricted to datasets
in which all but one member are equivalent using the prescribed comparison.
This vagueness is resolved by returning undefined unless there is only one
word found as unique, i.e. uniqueness is not odd when there are a multiple
unique items.
=end interpretation

sub oddity( @list --> Str ) {
    my @input = @list;
    @input.=map: {$_.comb.map(*.ord-97).rotor( 2=>-1).map( {$_[1]-$_[0]}).join(' ')};
    my %h = Hash.new.append: @input Z=> @list;
    my @runique = %h.values.grep( *.elems == 1);
    return @runique[0] if @runique.end == 0;
    return Nil;
}
multi MAIN ( 'test' ) {
    my @Test =
        xyz   =>(qw{ xyz },),
        bob   => qw{ aaa bob ccc ddd },
        abc   => qw{ adc wzy abc },
        (Nil) => qw{ adc way abc },
        aa    => qw{ aa ab bc de },
        (Nil) => qw{ aaa aab abc ade },
        aaaa  => qw{ aaaa aaab bbbc ddde },
        (Nil) => qw{ aaaa aaab bbbc ddde bbbb },
        (Nil) => qw{ aaaa azcd amcd alcd  },
    ;
    plan +@Test;
    for @Test -> %t {
        is oddity( %t.value), %t.key,  ' ' ~ %t.raku;
    }
    done-testing;
}
multi MAIN( @s = ("aaa", "bob", "ccc", "ddd") ) {
    say "Input: \@s = (", @s.join(', ') ~ ')' ;
    say "Output: ", oddity( @s ); 
}

