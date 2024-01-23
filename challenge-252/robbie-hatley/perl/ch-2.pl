#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 252-2.
Written by Robbie Hatley on Wed Jan 17, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 252-2: Unique Sum Zero
Submitted by: Mohammad S Anwar
You are given an integer, $n. Write a script to find an array
containing $n unique integers such that they add up to zero.

Example 1:
Input: $n = 5
Output: (-7, -1, 1, 3, 4)
Two other valid solutions are:
(-5, -1, 1, 2, 3) and (-3, -1, 2, -2, 4).

Example 2:
Input: $n = 3
Output: (-1, 0, 1)

Example 3:
Input: $n = 1
Output: (0)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This is actually much simpler than Task 1, for a change. The following algorithm provides one valid solution
(out of an always-infinite set of valid solutions) for each positive integer: Abort if $n is not a positive
integer. Make an empty array @a. Push (1..int($n/2)) to @a. If $n is odd, push 0 to @a. Then
push (-int($n/2)..-1) to @a. @a will now be $n elements long and will sum to 0, as the problem requires.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of positive integers, in proper Perl syntax:
./ch-2.pl '("dog",1,3,7,18)'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS AND MODULES USED:

use v5.38;
use strict;
use warnings;
use utf8;
use warnings FATAL => 'utf8';
use Sys::Binmode;
use Time::HiRes 'time';

# ------------------------------------------------------------------------------------------------------------
# GLOBAL VARIABLES:
our $t0    ; # Seconds since 00:00:00 on Thu Jan 1, 1970.
our $db = 1; # Debug? Set to 0 for no, 1 for yes.

# ------------------------------------------------------------------------------------------------------------
# START TIMER:
BEGIN {$t0 = time}

# ------------------------------------------------------------------------------------------------------------
# SUBROUTINES:

sub is_pos_int ($x) {
   return $x =~ m/^[1-9]\d*$/;
}

# Return array of $n unique ints adding to 0:
sub usz ($n) {
   my @a = ();
   push @a, -int($n/2)..-1;
   1 == $n%2 and push @a, 0;
   push @a, 1..int($n/2);
   return @a;
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Inputs:
my @inputs = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 Input:
   5,
   # Expected Output: (-2, -1, 0, 1, 2)

   # Example 2 Input:
   3,
   # Expected Output: (-1, 0, 1)

   # Example 3 Input:
   1,
   # Expected Output: (0)
);

# Main loop:
for my $n (@inputs) {
   say '';
   say 'Input  = ', $n;
   !is_pos_int($n) and say 'Error: input not positive integer.' and say 'Skipping to next input' and next;
   say 'Output = (' , join(', ', usz($n))  , ')';
}
exit;

# ------------------------------------------------------------------------------------------------------------
# DETERMINE AND PRINT EXECUTION TIME:
END {my $µs = 1000000 * (time - $t0);printf("\nExecution time was %.0fµs.\n", $µs)}
__END__
