#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 274-1,
written by Robbie Hatley on Mon Jun 17, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 274-1: Goat Latin
Submitted by: Mohammad Sajid Anwar
You are given a sentence, $sentance. Write a script to convert
$sentence to Goat Latin, a made up language similar to Pig Latin.

Rules for Goat Latin:

1) If a word begins with a vowel ("a", "e", "i", "o", "u"), append
   "ma" to the end of the word.
2) If a word begins with consonant i.e. not a vowel, remove first
   letter and append it to the end then add "ma".
3) Add letter "a" to the end of first word in the sentence, "aa"
   to the second word, etc.

Example 1:
Input: $sentence = "I love Perl"
Output: "Imaa ovelmaaa erlPmaaaa"

Example 2:
Input: $sentence = "Perl and Raku are friends"
Output: "erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa"

Example 3:
Input: $sentence = "The Weekly Challenge"
Output: "heTmaa eeklyWmaaa hallengeCmaaaa"

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
The tricky parts of this task are defining the terms "vowel", "consonant", "word", and "sentence".
The definitions used in English won't work here. Instead, I define these terms as follows:

"vowel"     = one of [aeiou] and case variants, with or without combining marks.
              (eg: ÅËiòU)
"consonant" = any character which is not a "vowel".
              (eg: b7$@ÐgÑ茶z)
"word"      = any cluster of non-horizontal-whitespace characters.
              (eg: "79.m:v", "du#f", "$17")
"sentence"  = any string consisting of "words" separated by horizontal whitespace.
              (eg: "79.m:v du#f $17")

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of double-quoted strings, apostrophes escaped as '"'"', in proper Perl syntax, like so:
./ch-1.pl '("He ate.", "Did she sit down?", "She ate 3.7 hot dogs.", "He didn'"'"'t take very many baths!")'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.38;
   use utf8;

   use Unicode::Normalize 'NFD';

   # Define "vowel" to mean one of aeiou or variants thereof (eg, ÅËiòU) :
   sub is_vowel ($x) {
      # Decompose any extended grapheme clusters within $x to
      # unmarked letters followed by separate combining marks:
      my $decomp = NFD $x;
      # Get rid of all characters except unmarked letters:
      my $unmarked = $decomp =~ s/[^\pL]+//gr;
      # Convert to lower-case:
      my $lower = lc $unmarked;
      # $x is a "vowel" if-and-only-if $lower is one of [aeiou]:
      return $lower =~ m/^[aeiou]{1}$/;
   }

   # Define "consonant" to mean "not a vowel" (eg, b7$@ÐgÑ茶z).
   # (Don't write a subroutine for this; use "else" or "!is_vowel".)

   # Define a "word" to be any cluster of non-horizontal-whitespace characters.
   # (eg: "79.m:v", "du#f", "$17")

   # Define a "sentence" to be any string consisting of "words"
   # separated by horizontal whitespace. (eg: "79.m:v du#f $17")

   # Convert a sentence to Goat Latin:
   sub goat ($x) {
      # Separate $x into "words" split by horizontal whitespace:
      my @words = split /\h+/, $x;
      # Process each "word" of the input by index:
      for ( my $idx = 0 ; $idx <= $#words ; ++$idx ) {
         # Grab a copy of the initial letter of the "word":
         my $init = substr($words[$idx], 0, 1);
         # If "word" starts with consonant, move first character to end of word:
         !is_vowel($init) and $words[$idx] = substr($words[$idx], 1) . $init;
         # Tack-on "ma" followed by 1+$idx copies of letter "a":
         $words[$idx] .= "ma" . "a"x(1+$idx);
      }
      # Join processed "words" with ' ':
      join ' ', @words;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @strings = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 input:
   "I love Perl",
   # Expected output: "Imaa ovelmaaa erlPmaaaa"

   # Example 2 input:
   "Perl and Raku are friends",
   # Expected output: "erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa"

   # Example 3 input:
   "The Weekly Challenge",
   # Expected output: "heTmaa eeklyWmaaa hallengeCmaaaa"
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $string (@strings) {
   say '';
   say "Original   sentence = $string";
   say "Goat-Latin sentence = ${\goat($string)}";
}
