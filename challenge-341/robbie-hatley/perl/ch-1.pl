#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 341-1,
written by Robbie Hatley on Thu Oct 2, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 341-1: Broken Keyboard
Submitted by: Mohammad Sajid Anwar
You are given a string containing English letters only, and you
are given a list of broken keys. Write a script to return the
total words in the given sentence can be typed completely.

Example #1 input: $str = 'Hello World', @keys = ('d')
Expected output: 1

Example #2 input: $str = 'apple banana cherry', @keys = ('a', 'e')
Expected output: 0

Example #3 input: $str = 'Coding is fun', @keys = ()
Expected output: 3

Example #4 input: $str = 'The Weekly Challenge', @keys = ('a','b')
Expected output: 2

Example #5 input: $str = 'Perl and Python', @keys = ('p')
Expected output: 1

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll join each "broken key" character and its "shift" (the other character using the same key) into a string
"$forbidden", then interpolate $forbidden into a regular-expression character class, then case-insensitively
match incoming words against that regexp and push non-matching words to array @allowed, like so:
for (@words) {if ($_ !~ m/[\Q$forbidden\E]/i) {push @allowed, $_}}
I'll then return the scalar of @allowed.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of a double-quoted string followed by an array of double-quoted single-character
strings, in proper Perl syntax, like so:

./ch-1.pl '(["I see a {big} rat!", ["]", "t"]], ["I spent \$5!", ["4"]], ["I drank 2 bottles of beer.", []])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, VARIABLES, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;
   no warnings "qw";

   my @lwr = qw{ ` 1 2 3 4 5 6 7 8 9 0 - = q w e r t y u i o p [
                 ] \ a s d f g h j k l ; ' z x c v b n m , . / };
   my @upr = qw[ ~ ! @ # $ % ^ & * ( ) _ + Q W E R T Y U I O P {
                 } | A S D F G H J K L : " Z X C V B N M < > ? ];
   my %shift;
   for my $idx (0..46) {$shift{$lwr[$idx]} = $upr[$idx]}
   for my $idx (0..46) {$shift{$upr[$idx]} = $lwr[$idx]}

   # How many words of a given string can
   # we type, given a list of bad keys?
   sub allowed_words ($str, @keys) {
      my @words = split /\s+/, $str;
      return scalar(@words) if 0 == scalar(@keys);
      my @broken;
      # Accumulate each key and its SHIFT in @broken:
      foreach my $key (@keys) {
         # The given character cannot be typed:
         push @broken, $key;
         # The SHIFT of that character can't be typed either:
         push @broken, $shift{$key}}
      my $forbidden = join '', @broken;
      my @allowed;
      for (@words) {
         if ($_ !~ m/[\Q$forbidden\E]/i) {
            push @allowed, $_}}
      scalar @allowed}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example #1 input:
   ['Hello World', ['d']],
   # Expected output: 1

   # Example #2 input:
   ['apple banana cherry', ['a', 'e']],
   # Expected output: 0

   # Example #3 input:
   ['Coding is fun', []],
   # Expected output: 3

   # Example #4 input:
   ['The Weekly Challenge', ['a','b']],
   # Expected output: 2

   # Example #5 input:
   ['Perl and Python', ['p']],
   # Expected output: 1
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=' ';
for my $aref (@arrays) {
   say '';
   my $str  = $aref->[0];
   my @keys = @{$aref->[1]};
   my $allowed = allowed_words($str, @keys);
   say "String = $str";
   say "Bad keys = @keys";
   say "Number of words we can type = $allowed"}
