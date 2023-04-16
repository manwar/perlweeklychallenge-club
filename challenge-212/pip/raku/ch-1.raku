#!/usr/bin/env raku
# HTTPS://TheWeeklyChallenge.Org - Perl/Raku Weekly Challenge #212 - Pip Stuart
# Task1: Jumping Letters:  Submitted by: Mohammad S Anwar;  You are given a word having alphabetic characters only, and a list of positive integers of the
#   same length. Write a script to print the new word generated after jumping forward each letter in the given word by the integer in the list.
#   The given list would have exactly the number as the total alphabets in the given word.
# Example1:
#   In-put: $word = 'Perl' and @jump = (2,22,19,9)
#   Output: Raku
#     'P' jumps 2  place forward and becomes 'R'.
#     'e' jumps 22 place forward and becomes 'a'. (jump is cyclic i.e. after 'z' you go back to 'a')
#     'r' jumps 19 place forward and becomes 'k'.
#     'l' jumps 9  place forward and becomes 'u'.
# Example2:
#   In-put: $word = 'Raku' and @jump = (24,4,7,17)
#   Output: 'Perl'
use v6;my $d8VS='N4GMGist';
sub JmpL {my @jump = @_;my @word = split('', shift(@jump), :skip-empty);my $jmpw = '';my @letz = ('a'..'z');my %lnlu = (); # LetteriNdexLookUp
  for (0..@letz.elems - 1) { %lnlu{@letz[$_]} = $_; }
  for (0..@word.elems - 1) { my $letr = lc(@word[$_]);my $lucf = 0;$lucf = 1 if (@word[$_] eq uc(@word[$_])); # LetterUpperCaseFlag
    $letr = @letz[(%lnlu{$letr} + @jump[$_]) % @letz.elems];$letr = uc($letr) if ($lucf);$jmpw ~= $letr; }
  say "word:'" ~  join('', @word) ~ "' jump:(" ~ join(',', @jump) ~ ") => '$jmpw';";
  return($jmpw);
}
if    (@*ARGS) {
  JmpL(@*ARGS);
} else {
  JmpL('Perl', 2, 22, 19, 9); # => Raku;
  JmpL('Raku', 24, 4, 7, 17); # => Perl;
}
