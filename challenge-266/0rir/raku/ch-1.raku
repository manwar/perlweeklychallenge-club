#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
266-1: Uncommon Words           Submitted by: Mohammad Sajid Anwar
You are given two sentences, $line1 and $line2.

Write a script to find all uncommmon words in any order in the given two sentences. Return ('') if none found.

A word is uncommon if it appears exactly once in one of the sentences and doesn’t appear in other sentence.

Example 1
Input: $line1 = 'Mango is sweet'
       $line2 = 'Mango is sour'
Output: ('sweet', 'sour')
Example 2
Input: $line1 = 'Mango Mango'
       $line2 = 'Orange'
Output: ('Orange')
Example 3
Input: $line1 = 'Mango is Mango'
       $line2 = 'Orange is Orange'
Output: ('')
=end comment

my @Test =
    #  in-a           in-b                result             result-lc
    'Mango is sweet', 'Mango is sour',    ('sweet', 'sour'), ('sweet', 'sour'),
    'Mango Mango',    'Orange',           ('Orange',),       ('orange',),
    'Mango is Mango', 'Orange is Orange', ('',),             ('',),
    '',               '',                 ('',),             ('',),
;
plan @Test ÷ 2;

# ignore case by using .lc
multi once-words( Bool :$lc!, *@word-text -->List) {
    (@word-text.words».lc).Bag.grep( *.value == 1)».key;
}
# case sensitive
multi once-words( *@word-text -->List) {
    @word-text.words.Bag.grep( *.value == 1)».key;
}

for @Test -> $l1, $l2, @exp, @lc {
    is once-words(      $l1, $l2).sort, @exp.sort, "@exp[] <- $l1 / $l2";
    is once-words( :lc, $l1, $l2).sort, @lc.sort,   "@lc[] <- $l1 / $l2";
}

done-testing;

my $line1 = 'Ripe mango is sweet';
my $line2 = 'New mango is sour';
say "\nInput: \$line1 = '$line1'\n"
    ~ "       \$line2 = '$line2'\nOutput: ", 
  $ =  (once-words( $line1, $line2)».&( "'" ~ * ~ "'")) ~~ Empty
    ?? "('')"
    !! (once-words( $line1, $line2)».&( "'" ~ * ~ "'"));

