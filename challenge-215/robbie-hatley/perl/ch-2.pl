#! /bin/perl -CSDA

=pod

------------------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 120-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

------------------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
ch-2.pl
Robbie Hatley's Perl solutions for The Weekly Challenge 215-2.
Written by Robbie Hatley on Tue May 2, 2023.

------------------------------------------------------------------------------------------------------------------------
Task 2: Number Placement
Submitted by: Mohammad S Anwar
You are given a list of numbers having just 0 and 1. You are also given placement count (>=1). Write a script to find
out if it is possible to replace 0 with 1 the given number of times in the given list. The only condition is that you
can only replace when there is no 1 on either side. Print 1 if it is possible otherwise 0.

Example 1:  Input: @numbers = (1,0,0,0,1),         $count = 1  Output: 1
Example 2:  Input: @numbers = (1,0,0,0,1),         $count = 2  Output: 0
Example 3:  Input: @numbers = (1,0,0,0,0,0,0,0,1), $count = 3  Output: 1

------------------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
Conceptually, this is even simpler than Task 1: Just replace what we can, keep tally, and if tally >= $count, print 1,
else 0. But in-practice, there is the annoying matter of "special cases": Arrays of sizes 0,1,2 and the 0th and last
elements of every array. Those all need to be handled separately, so it's not just a case of writing a sub and applying
it to every element of an array using a for loop. In fact, I ended up using NO subs but a disgusting number of "if"
statements to handle the special cases.

------------------------------------------------------------------------------------------------------------------------
INPUT / OUTPUT NOTES:

Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a single-quoted
array of arrays in proper Perl syntax, with each inner array being a list of 1s and 0s followed by count. Eg:
./ch-2.pl '([1,0,1,0,1,1],[1,0,0,0,2],[1,0,0,0,1],[0,1,0,0,0,0,0,0,0,0,1,2])'

Output is to STDOUT and will be list of numbers, count, and number of replacements, on separate lines.

=cut

# ----------------------------------------------------------------------------------------------------------------------
# PRELIMINARIES:
use v5.36;
use strict;
use warnings;
use utf8;
use Sys::Binmode;
use Time::HiRes 'time';
$"=', ';

# ----------------------------------------------------------------------------------------------------------------------
# DEFAULT INPUTS:
my @arrays =
(
   [1,0,0,0,1,1],
   [1,0,0,0,1,2],
   [1,0,0,0,0,0,0,0,1,3],
);

# ----------------------------------------------------------------------------------------------------------------------
# NON-DEFAULT INPUTS:
if (@ARGV) {@arrays = eval($ARGV[0]);}

# ----------------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
{ # begin main
   my $t0 = time;
   for my $aref (@arrays) {
      my @numbers = @$aref;                                  # "Original" copy of array.
      my $count   = pop @numbers;                            # Pop "desired replacement count" off end of @numbers.
      my @mutable = @numbers;                                # "Working" copy of @numbers; this may get altered.
      my $yes   = 0;                                         # WAS @mutable altered?
      my $tally = 0;                                         # If so, how many TIMES was it altered?
      my $sz    = scalar(@mutable);                          # Size of @mutable.

      # First of all, we need to handle three bloody-annoying "special-case" array sizes: 0, 1, 2:

      if    ( 0 == $sz ) {                                   # If array has 0 elements:
         ;                                                   # No replacements are possible, so do nothing.
      }

      elsif ( 1 == $sz ) {                                   # Else if array has 1 element:
         if ( $mutable[0] == 0 ) {                           # If element is 0,
            $mutable[0] = 1;                                 # replace 0 with 1
            ++$tally;                                        # and increment tally.
         }
      }

      elsif ( 2 == $sz ) {                                   # Else if array has 2 elements:
         if ( $mutable[0] == 0                               # If  0th element is 0
           && $mutable[1] != 1 ) {                           # and 1st element is not 1,
            $mutable[0] = 1;                                 # replace 0 with 1
            ++$tally;                                        # and increment tally.
         }
         if ( $mutable[1] == 0                               # If  1st element is 0,
           && $mutable[0] != 1 ) {                           # and 0th element is not 1
            $mutable[1] = 1;                                 # replace 0 with 1
            ++$tally;                                        # and increment tally.
         }
      }                                                      # at-most-one 0 can be replaced by 1.)

      # Now, finally, we can get on with the code for the vast majority of cases, in which $sz > 2:

      else {                                                 # Else array has 3-or-more elements:
         if ( $mutable[0] == 0                               # If  0th element is 0,
           && $mutable[1] != 1) {                            # and 1st element is not 1,
            $mutable[0] = 1;                                 # replace 0 with 1
            ++$tally;                                        # and increment tally.
         }
         for ( my $i = 1 ; $i <= $#mutable-1 ; ++$i ) {      # For each non-end element,
            if ( $mutable[$i] == 0                           # if it's 0
              && $mutable[$i-1] != 1                         # and element to left  is not 1
              && $mutable[$i+1] != 1 ) {                     # and element to right is not 1
               $mutable[$i] = 1;                             # replace 0 with 1
               ++$tally;                                     # and increment tally.
            }
         }
         if ( $mutable[$#mutable] == 0                       # If last element is 0,
           && $mutable[$#mutable-1] != 1 ) {                 # and penultimate element is not 1,
            $mutable[$#mutable] = 1;                         # replace 0 with 1
            ++$tally;                                        # and increment tally.
         }
      }

      if ($tally >= $count) {                                # If we were able to make AT-LEAST as many replacements
         $yes = 1;                                           # as were requested, then set $yes to 1;
      }                                                      # else leave it set to 0.

      say '';                                                # Print results:
      say "numbers:    (@numbers)";                          # Original input array.
      say "quota:      $count";                              # Requested replacement count.
      say "replaced:   $tally";                              # Tally of actual replacements.
      say "met quota?: $yes";                                # Output.
   }
   my $µs = 1000000 * (time - $t0);                          # Calculate elpased time in µs,
   printf("\nExecution time was %.3fµs.\n", $µs);            # print elapsed time,
   exit 0;                                                   # and exit program.
} # end main
