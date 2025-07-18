#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 330-1,
written by Robbie Hatley on Thu Jul 17, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 330-1: Clear Digits
Submitted by: Mohammad Sajid Anwar
You are given a string containing only lower case English letters
and digits. Write a script to remove all digits by removing the
first digit and the closest non-digit character to its left.

Example #1:
Input: $str = "cab12"
Output: "c"
Round 1: remove "1" then "b" => "ca2"
Round 2: remove "2" then "a" => "c"

Example #2:
Input: $str = "xy99"
Output: ""
Round 1: remove "9" then "y" => "x9"
Round 2: remove "9" then "x" => ""

Example #3:
Input: $str = "pa1erl"
Output: "perl"

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I note that it will not be POSSIBLE to remove "the character to the left of a digit" if the index of the digit
is 0; so in that case, I'll just skip removing "character to left". In all other cases, I'll remove both each
digit and the character to it's left. I'll use a 3-part index loop with double backtracking to avoid missing
digits, and just keep erasing digits (and their left-hand men) until no digits remain.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of double-quoted strings, in proper Perl syntax, like so:

./ch-1.pl '("Peg9rq7lg5", "ragu37t", "0817354629bat", "polenastyisrat0192837465cat")'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;

   # Clear digits and their left-hand men:
   sub clear_digits_and_left ($s) {
      for ( my $idx = 0 ; $idx <= length($s)-1 ; ++$idx ) {
         if ( substr($s, $idx, 1) =~ m/\d/ ) {
            substr $s, $idx - 0, 1, '';
            substr $s, $idx - 1, 1, '' if $idx > 0;
            --$idx;
            --$idx}}
      return $s}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @strings = @ARGV ? eval($ARGV[0]) : ("cab12", "xy99", "pa1erl");
#                   Expected outputs : (  "c"  ,   ""  ,  "perl" )

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $string (@strings) {
   say '';
   say "String = \"$string\"";
   my $cdal = clear_digits_and_left($string);
   say "CDAL   = \"$cdal\"";
}
