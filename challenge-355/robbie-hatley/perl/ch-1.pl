#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 355-1,
written by Robbie Hatley on Mon Jan 05, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 355-1: Thousand Separator
Submitted by: Mohammad Sajid Anwar
You are given a positive integer, $int. Write a script to add
thousand separator, "," and return as string.

Example #1:
Input: $int = 123
Output: "123"

Example #2:
Input: $int = 1234
Output: "1,234"

Example #3:
Input: $int = 1000000
Output: "1,000,000"

Example #4:
Input: $int = 1
Output: "1"

Example #5:
Input: $int = 12345
Output: "12,345"

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll write a subroutine which splits each integer to its decimal digits, then pops each digit from the right
end of the array and appends it to the left end of an output string, first appending "," if the index is
positive and 0 modulo 3. Then just return the output string.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of positive integers, in proper Perl syntax, like so:

./ch-1.pl '(8, 37, 163, 8497, 39675, 284634, 2946306, 1085634475)'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;

   # Add commas to a positive decimal integer:
   sub add_commas ( $int ) {
      my @chars = split //, $int;
      my $out = '';
      my $idx = 0;
      while (@chars) {
         $out = ','.$out if $idx > 0 && 0 == $idx%3;
         $out = pop(@chars).$out;
         ++$idx}
      return $out}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @ints = @ARGV ? eval($ARGV[0]) : ( 123 ,  1234 ,   1000000 , 1 ,  12345 );
#                Expected outputs :   123   1,234   1,000,000   1   12,345

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $int (@ints) {
   say '';
   my $iwc = add_commas $int;
   say "Positive integer WITHOUT commas: $int";
   say "Positive integer   WITH  commas: $iwc";
}
