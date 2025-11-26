#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
349-2: Meeting Point        Submitted by: Mohammad Sajid Anwar
You are given instruction string made up of U (up), D (down), L (left) and R (right).
Write a script to return true if following the instruction, you meet (0,0) at any point along the sequence.
=end comment

my @Test =
    "ULD",          False,
    "ULDR",         True,
    "UUURRRDDD",    False,
    "UURRRDDLLL",   True,
    "RRUULLDDRRUU", True,
;
plan +@Test ÷ 2;

# instruction codes
constant UP    = 'U';
constant DOWN  = 'D';
constant LEFT  = 'L';
constant RIGHT = 'R';

sub task( Str:D $a -->Bool) {
    my @curr = 0,0;
    for ^$a.chars -> \i{
        my \c = $a.substr( i,1);
        sink                DOWN  eq c ?? ++@curr[0]
            !!              UP    eq c ?? --@curr[0]
                !!          LEFT  eq c ?? ++@curr[1]
                    !!      RIGHT eq c ?? --@curr[1]
                        !!  die "Invalid direction '&c()'";

        return True if @curr[0] == 0 and @curr[1] == 0;
    }
    False;
}

for @Test -> $in, $exp {
    is task( $in), $exp, "{$exp // $exp.^name()} <- $in.raku()";
}
done-testing;

my $path = "RRUULLDDRRUU";
say qq{\nInput: \$path = "$path"\nOutput: }, lc task $path;
