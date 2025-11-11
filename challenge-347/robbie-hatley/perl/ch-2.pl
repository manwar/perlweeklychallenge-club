#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 347-2,
written by Robbie Hatley on Tue Nov 11, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 347-2: Format Phone Number
Submitted by: Mohammad Sajid Anwar
You are given a phone number as a string. Write a script to
format the given phone number using these rules:
1. Remove all non-digit characters.
2. Group digits into blocks of length 3 from left to right.
3. Handle the final digits (4 or fewer) specially:
   - 0 digits: zero blocks
   - 1 digits: one block of length 1
   - 2 digits: one block of length 2
   - 3 digits: one block of length 3
   - 4 digits: two blocks of length 2
4. Join all blocks with dashes.

Example #1:
Input:  "1-23-45-6"
Output: "123-456"

Example #2:
Input:  "1234"
Output: "12-34"

Example #3:
Input:  "12 345-6789"
Output: "123-456-789"

Example #4:
Input:  "123 4567"
Output: "123-45-67"

Example #5:
Input:  "123 456-78"
Output: "123-456-78"

Example #6:
Input:  "42"
Output: "42"

Example #7:
Input:  ""
Output: ""

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this problem, I'll use Perl's "substr" function to splice-off chunks of size 3 from the left while
the size of the remainder is greater than 4, then handle the final 0-to-4 digits as described.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of double-quoted strings, in proper Perl syntax, like so:

./ch-2.pl '("1973 20393-382-2-34833", "2043-3946 G 2845-3950", "47", "8", "")'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;

   # Convert phone format:
   sub format_phone ( $s ) {
      $s =~ s/\D//g;
      my @nums = ();
      while ( 1 ) {
            if ( length($s) > 4  ) {push @nums, substr $s, 0, 3, ''}
         elsif ( 4 == length($s) ) {push @nums, substr $s, 0, 2, '';
                                    push @nums, substr $s, 0, 2, ''}
         elsif ( 3 == length($s) ) {push @nums, substr $s, 0, 3, ''}
         elsif ( 2 == length($s) ) {push @nums, substr $s, 0, 2, ''}
         elsif ( 1 == length($s) ) {push @nums, substr $s, 0, 1, ''}
         else {last}}
      join '-', @nums}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @phones = @ARGV ? eval($ARGV[0])
                   : ("1-23-45-6", "1234", "12 345-6789", "123 4567", "123 456-78");
# Expected outputs:   "123-456"    "12-34" "123-456-789"  "123-45-67" "123-456-78"

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $p1 (@phones) {
   say '';
   say "Old phone = $p1";
   my $p2 = format_phone $p1;
   say "New phone = $p2";
}
