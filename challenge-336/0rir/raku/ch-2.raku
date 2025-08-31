#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.e.PREVIEW;
use Test;

=begin comment
336-2: Final Score          Submitted by: Mohammad Sajid Anwar

You are given an array of scores by a team.

Write a script to find the total score of the given team. The score can be any integer, +, C or D. The + adds the sum of previous two scores. The score C invalidates the previous score. The score D will double the previous score.


Example 1
Input: @scores = ("5","2","C","D","+")
Output: 30

Example 2
Input: @scores = ("5","-2","4","C","D","9","+","+")
Output: 27

Round 1: 5
Round 2: 5 + (-2)
Round 3: 5 + (-2) + 4
Round 4: 5 + (-2) (invalidate the previous score 4)
Round 5: 5 + (-2) + (-4) (double the previous score -2)
Round 6: 5 + (-2) + (-4) + 9
Round 7: 5 + (-2) + (-4) + 9 + 5 (sum of previous two scores)
Round 8: 5 + (-2) + (-4) + 9 + 5 + 14 (sum of previous two scores)

Total Scores: 27

Example 3
Input: @scores = ("7","D","D","C","+","3")
Output: 45

Example 4
Input: @scores = ("-5","-10","+","D","C","+")
Output: -55

Example 5
Input: @scores = ("3","6","+","D","C","8","+","D","-2","C","+")
Output: 128

=end comment

my @Test =
#   # @in                                           $exp
    ("5","2","C","D","+"),                           30,
    ("5","-2","4","C","D","9","+","+"),              27,
    ("7","D","D","C","+","3"),                       45,
    ("-5","-10","+","D","C","+"),                   -55,
    ("3","6","+","D","C","8","+","D","-2","C","+"), 128,

    ('1', '1'),                                       2,
;
plan +@Test;

grammar Final-score {
    rule  TOP    {  ^ <number> [[ <plus> |<double>|<cancel>] | <number> ]+ $ }
    token number {  [ '+' | '-'] ? \d+  }
    token plus   { '+' }
    token double { 'D' }
    token cancel { 'C' }
}

class Fs    {
    has @.score = [0,];
    method TOP(    $/)  { $/.make: @.score.sum; }
    method number( $/)  { @.score.push: $/.Int; }
    method plus(   $/)  { @.score.push: (@.score[*-2,*-1]).sum; }
    method double( $/)  { @.score.push: (@.score[*-1].Int × 2).Int; }
    method cancel( $/)  { @.score.pop; }
}

sub task( $a --> Int) {
    my $m = Final-score.parse: $a.join( ' '), :actions(Fs.new);
    $m.made.Str.Int;
}

for @Test -> $code, $exp {
    my $m = Final-score.parse: $code.join( ' ');
    is $m.Str, $code.join(' '), 'parses';
    is task($code), $exp, "$exp <- $code.raku()";
}
done-testing;
my @score =  "-5","-10","+","D","C","+";

say qq{\nInput: @score = ["{@score.join: '","' }"]\nOutput: }, task @score;
