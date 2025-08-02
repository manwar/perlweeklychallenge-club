#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use Test;

=begin comment
Task 2: Dictionary Rank
Submitted by: Mark Anderson         You are given a word, $word.  Write a
script to compute the dictionary rank of the given word.

Example 1
Input: $word = 'CAT'
Output: 3

All possible combinations of the letters:
CAT, CTA, ATC, TCA, ACT, TAC

Arrange them in alphabetical order:
ACT, ATC, CAT, CTA, TAC, TCA

CAT is the 3rd in the list.
Therefore the dictionary rank of CAT is 3.
Example 2
Input: $word = 'GOOGLE'
Output: 88
Example 3
Input: $word = 'SECRET'
Output: 255
=end comment

=begin comment
I am just using the built-in &permutation, but this can be calculated more
efficiently than generating the permutations.

'TADE' and 'TEDA', since they start with the 4th ranked letter, will be in
the index range 4! minus 3! … 4!  So with bookkeeping the problem can be
partitioned and repartitioned.  This simplification doesn't address that
duplicates share identity.
=end comment

my @Test =
    Str,        Int,
    '',         Int,
    'XYZ',      1,
    "ooO",      1,
    'Deet',     1,
    'CAT',      3,
    'TADE',     19,
    'Cat',      3,
    'GOOGLE',   88,
    'SECRET',   255,
;
plan @Test ÷ 2;

# grind it
multi gen( Str:U $a                -->Int) { Int }
multi gen( Str:D $a where * eqv '' -->Int) { Int }
multi gen( Str:D $a -->Int) {
    ( $a.fc.comb.permutations».join).unique.sort.first( $a.fc, :k) + 1
}

for @Test -> $in, $exp {
   is gen($in), gen($in), "$exp.raku() <- $in.raku()";
}

done-testing;
my $word = 'Supercad';
say "\nInput: \$word = $word\nOutput: &gen($word)";


