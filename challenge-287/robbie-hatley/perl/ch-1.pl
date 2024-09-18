#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 287-1,
written by Robbie Hatley on Tue Sep 17, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 287-1: Strong Password
Submitted by: Mohammad Sajid Anwar
You are given a string, $str. Write a program to return the
minimum number of steps required to make the given string a
"strong password". If the string is already a "strong password",
then return 0.

The definition of "strong password" is as follows:
- It must have at least 6 characters.
- It must contain at least one lowercase letter
- It must contain at least one uppercase letter
- It must contain at least one digit
- It mustn't contain 3 repeating characters in a row

Each of the following is considered one "step":
- Insert one character
- Delete one character
- Replace one character with another

Example 1:  Input: $str = "a"          Output: 5
Example 2:  Input: $str = "aB2"        Output: 3
Example 3:  Input: $str = "PaaSW0rd"   Output: 0
Example 4:  Input: $str = "Paaasw0rd"  Output: 1
Example 5:  Input: $str = "aaaaa"      Output: 2

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll start by writing subs to do these two things:
 - Determine the least-abundant type of character in a given string.
 - Make a strong password out of any string.

That last sub will involve doing the following:
1. For each identical triplet, insert a character of least-abundant type between 2nd & 3rd chars of triplet,
   making sure that it doesn't match what's to its left or right.
2. While we don't have all required types, tack a least-abundant character to the end,
   making sure that it doesn't match the character to its left.
3. While length < 6, tack a symbol to the end,
   making sure that it doesn't match the character to its left.
4. Increment a step counter each time we insert a character.
5. Return strong password and number of steps required to strengthen it.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of double-quoted strings, in proper Perl syntax, like so:
./ch-1.pl '("Fkkg4e u)888hE dkiI?", "She ate 7 hot dogs.", "#)^*")'

Output is to STDOUT and will be each weak password followed by strengthened password and number-of-steps.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, VARIABLES, AND SUBS:

use v5.36;
no warnings 'qw';

# What is the least-abundant type of character in a given string?
sub least :prototype($) ($p) {
   my %types = ('L' => 0, 'U' => 0, 'D' => 0);
   for my $c (split '', $p) {
      $c =~ m/[a-z]/ and ++$types{'L'} and next;
      $c =~ m/[A-Z]/ and ++$types{'U'} and next;
      $c =~ m/[0-9]/ and ++$types{'D'} and next;
   }
   my @sorted = sort {$types{$a}<=>$types{$b}} keys %types;
   return $sorted[0];
}

# Morph any string into a "strong password":
sub make_strong :prototype($) ($p) {
   # Start by making a "count of steps" counter and initializing it to zero:
   my $c = 0;
   # Now, make four arrays of different types of characters, for strengthening our password:
   my %types =
   (
      'L' => [qw( a b c d e f g h i j k l m n o p q r s t u v w x y z )], # Lower
      'U' => [qw( A B C D E F G H I J K L M N O P Q R S T U V W X Y Z )], # Upper
      'D' => [qw( 0 1 2 3 4 5 6 7 8 9                                 )], # Digits
      'O' => [qw( ~ ! @ # $ % ^ & * + - = : ; \ | / ?                 )], # Other
   );
   # Next, get rid of any triplets.
   # (I'm using a 3-part loop here because a ranged foreach won't work because the size of $p changes.)
   foreach ( my $i = 0 ; $i <= length($p) - 3 ; ++$i ) {
      my $first  = substr($p, $i+0, 1);
      my $second = substr($p, $i+1, 1);
      my $third  = substr($p, $i+2, 1);
      # Are the next three characters all equal? If so, we have a triplet here and we need to break it up:
      if ($second eq $first && $third eq $first) {
         # Insert a least-abundant character between second and third characters of triplet:
         my $least = least($p);
         my $insert = $types{$least}->[int rand scalar @{$types{$least}}];
         redo if $insert eq $second || $insert eq $third;
         substr($p, $i+1, 1, $second.$insert);
         ++$c;
      }
   }
   # Now, as long as we don't have all three required types of characters, keep tacking-on the least abundant:
   while ( $p !~ m/[a-z]/ || $p !~ m/[A-Z]/ || $p !~ m/[0-9]/ ) {
      # Tack a least-abundant character to the end:
      my $least = least($p);
      my $insert = $types{$least}->[int rand scalar @{$types{$least}}];
      redo if $insert eq substr($p, -1, 1);
      $p .= $insert;
      ++$c;
   }
   # Finally, while our password is still less than 6 characters long, tack-on some symbols to lengthen it:
   while ( length($p) < 6 ) {
      my $insert = $types{'O'}->[int rand scalar @{$types{'O'}}];
      redo if $insert eq substr($p, -1, 1);
      $p .= $insert;
      ++$c;
   }
   return ($p,$c);
}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @passwords = @ARGV ? eval($ARGV[0]) : ('a', 'aB2', 'PaaSW0rd', 'Paaasw0rd', 'aaaaa');
# Expected outputs:                        5     3         0           1          2

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $p (@passwords) {
   say '';
   say "Original password   = $p";
   my ($s,$c) = make_strong($p);
   say "Strong   password   = $s";
   say "Steps to strengthen = $c";
}
