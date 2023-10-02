#! /bin/perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 229-2.
Written by Robbie Hatley on Mon Aug 07, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 2: Two out of Three
Submitted by: Mohammad S Anwar
You are given three array of integers. Write a script to return all the elements that are present in at least
2 out of 3 given arrays.

Example 1:
   Input:  @array1 = (1, 1, 2, 4)
           @array2 = (2, 4)
           @array3 = (4)
   Ouput:  (2, 4)

Example 2
   Input:  @array1 = (4, 1)
           @array2 = (2, 4)
           @array3 = (1, 2)
   Ouput:  (1, 2, 4)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This is one of those rare Weekly Challenge problems for which I'm going to write a whole mess of subroutines.
At the very least, I'll need subs to answer the following 6 questions:
1. Does a given scalar represent an integer?
2. Does a given reference refer to an array of integers?
3. Does a given reference refer to an array of 3 arrays of integers?
4. Does a given array of integers contain a given integer?
5. Given an array of 3 arrays of integers and an integer, how many of those arrays is the integer in?
6. Given an array of 3 arrays of integers, which elements appear in at-least-two of those arrays?
The later subs all depend heavily on earlier subs, so this will be a "tree-structured" design (as opposed
to the "linear-procedural" paradigm of most of my Perl scripts).

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be
a double-quoted array of arrays of 3 arrays of integers, in proper Perl syntax, like so:
./ch-2.pl "([[1,2,3],[2,3,4],[3,4,5]],[[2,1,3,44],[4,8,2,7,4],[9,8,15,56,67,78]])"

Output is to STDOUT and will be each set of input arrays followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRELIMINARIES:

use v5.36;
use strict;
use warnings;
use utf8;
use Sys::Binmode;
use Time::HiRes 'time';
$"=', ';

# ------------------------------------------------------------------------------------------------------------
# SUBROUTINES:

# Does a given scalar represent an integer?
sub is_int ($x) {
   return $x =~ m/^-[1-9]\d*$|^0$|^[1-9]\d*$/;
}

# Does a given reference refer to an array of integers?
sub is_array_of_ints ($aref) {
   return 0 if 'ARRAY' ne ref $aref;
   for my $element (@$aref) {return 0 unless is_int($element)}
   return 1;
}

# Does a given reference refer to an array of 3 arrays of integers?
sub is_array_of_3_arrays_of_ints ($aaref) {
   return 0 if 'ARRAY' ne ref $aaref;
   return 0 if 3 != scalar @$aaref;
   for my $aref (@$aaref) {return 0 unless is_array_of_ints($aref);}
   return 1;
}

# Does a given array of integers contain a given integer?
sub is_in_array ($aref, $x) {
   for (@$aref) {return 1 if $x == $_}
   return 0;
}

# Given an array of 3 arrays of integers and an integer, how many of those arrays is the integer in?
sub is_in_how_many_arrays ($aaref, $x) {
   my $in_arrays = 0;
   for my $aref (@$aaref) {
      ++$in_arrays if is_in_array($aref, $x);
   }
   return $in_arrays;
}

# Given an array of 3 arrays of integers, which elements appear in at-least-two of those arrays?
sub at_least_two ($aaref) {
   my %h;
   my @at_least_two = ();
   for my $aref (@$aaref) {
      for my $element (@$aref) {
         # If this is the first we've seen of this element, record how many arrays it's in,
         # and if it's in 2-or-more arrays, push it to @at_least_two :
         if ( ! defined $h{$element} ) {
            $h{$element} = is_in_how_many_arrays($aaref, $element);
            if ($h{$element} >= 2) {push @at_least_two, $element}
         }
      }
   }
   return sort {$a<=>$b} @at_least_two;
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Start timer:
my $t0 = time;

# Default inputs:
my @aaa =
(
   [
      [1, 1, 2, 4],
      [2, 4],
      [4],
   ],
   [
      [4, 1],
      [2, 4],
      [1, 2],
   ]
);

# Non-default inputs:
@aaa = eval($ARGV[0]) if @ARGV;

# Main loop:
for my $aaref (@aaa) {
   say '';
   if ( ! is_array_of_3_arrays_of_ints($aaref) ) {
      say "This isn't an array of 3 arrays of integers. Moving on to next array.";
      next;
   }
   say "arrays:";
   for my $aref (@$aaref) {say "(@$aref)"}
   my @two_of_three = at_least_two($aaref);
   say "elements appearing in at least two arrays:";
   say "(@two_of_three)";
}

# Determine and print execution time:
my $µs = 1000000 * (time - $t0);
printf("\nExecution time was %.0fµs.\n", $µs);
