#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 363-1,
written by Robbie Hatley on Tue Mar 3, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 363-1: String Lie Detector
Submitted by: Mohammad Sajid Anwar
You are given a string. Write a script that parses a
self-referential string and determines whether its claims about
itself are true. The string will make statements about its own
composition, specifically the number of vowels and consonants
it contains.

(
   # Example #1 input:
   "aa — two vowels and zero consonants",
   # Expected output: true

   # Example #2 input:
   "iv — one vowel and one consonant",
   # Expected output: true

   # Example #3 input:
   "hello - three vowels and two consonants",
   # Expected output: false

   # Example #4 input:
   "aeiou — five vowels and zero consonants",
   # Expected output: true input:

   # Example #5 input:
   "aei — three vowels and zero consonants",
   # Expected output: true
);

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll assume that the input stream will always match this regexp:
^\pL+[\pP\pZ]+\pL+\pZ+\pL+\pZ+\pL+\pZ+\pL+\pZ+\pL+$
So I'll split on /[\pP\pZ]+/ and store the result to an array:
my $fields = split /[\pP\pZ]+/, $string;
Then I'll return "true" if ALL of the following are true, else return "false":
1. Number of fields is 6
2. Second field is number.
3. Third  field is "vowel(s)".
4. Fourth field is "and"
5. Fifth  field is number.
6. Sixth  field is "consonant(s)".
7. Second field accurately describes number of   vowels   in first field.
8. Fifth  field accurately describes number of consonants in first field.
That approach will work for numbers up to 20. Larger numbers would require more-elaborate programming,
which I don't have time for, so this approach will have to do.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of double-quoted strings, in proper Perl syntax, like so:

./ch-1.pl '("eeotouisdjhggtjhu - seven vowels and ten consonants", "weior - ten vowels and ten consonants")'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;
   use Unicode::Normalize 'NFD';

   # Names for numbers:
   my %numbers =
   (
      'zero'    =>  0, 'one'     =>  1, 'two'       =>  2,  'three'   =>  3,  'four'    =>  4,
      'five'    =>  5, 'six'     =>  6, 'seven'     =>  7,  'eight'   =>  8,  'nine'    =>  9,
      'ten'     => 10, 'eleven'  => 11, 'twelve'    => 12, 'thirteen' => 13, 'fourteen' => 14,
      'fifteen' => 15, 'sixteen' => 16, 'seventeen' => 17, 'eighteen' => 18, 'nineteen' => 19,
      'twenty'  => 20,
   );

   # String Lie Detector:
   sub string_lie_detector ( $string ) {
      my @fields = split /[\pP\pZ]+/, $string;
      return 'false' if 6 != scalar @fields;
      return 'false' if                   $fields[0] !~ m/^\pL+$/;
      return 'false' if !defined $numbers{$fields[1]};
      return 'false' if                   $fields[2] !~ m/^vowels?$/;
      return 'false' if 'and'          ne $fields[3];
      return 'false' if !defined $numbers{$fields[4]};
      return 'false' if                   $fields[5] !~ m/^consonants?$/;
      $fields[0] = NFD $fields[0];
      $fields[0] =~ s/\pM//g;
      my @chars = split //, $fields[0];
      my $numvow = 0; my $numcon = 0;
      for my $char (@chars) {
         ++$numvow if $char =~ m/[aeiouyAEIOUY]/;
         ++$numcon if $char =~ m/[bcdfghjklmnpqrstvwxyBCDFGHJKLMNPQRSTVWXYZ]/;
      }
      return 'false' if $numvow != $numbers{$fields[1]};
      return 'false' if $numcon != $numbers{$fields[4]};
      return 'true';
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @strings = @ARGV ? eval($ARGV[0]) :
(
   # Example #1 input:
   "aa — two vowels and zero consonants",
   # Expected output: true

   # Example #2 input:
   "iv — one vowel and one consonant",
   # Expected output: true

   # Example #3 input:
   "hello - three vowels and two consonants",
   # Expected output: false

   # Example #4 input:
   "aeiou — five vowels and zero consonants",
   # Expected output: true

   # Example #5 input:
   "aei — three vowels and zero consonants",
   # Expected output: true
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $string (@strings) {
   say '';
   say "String = $string";
   my $tf = string_lie_detector($string);
   say "String telling truth? $tf";
}
