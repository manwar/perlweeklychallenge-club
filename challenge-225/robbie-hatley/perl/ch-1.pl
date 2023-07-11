#! /bin/perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
ch-1.pl
Solutions in Perl for The Weekly Challenge 225-1.
Written by Robbie Hatley on Sunday July 9, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 1: Max Words
Submitted by: Mohammad S Anwar
Given a list of sentences, write a script to find the maximum word count of the sentences of the list.

Example 1:
Input:
   @list =
   (
      "Perl and Raku belong to the same family.",
      "I love Perl.",
      "The Perl and Raku Conference."
   );
Output: 8

Example 2:
Input:
   @list =
   (
      "The Weekly Challenge.",
      "Python is the most popular guest language.",
      "Team PWC has over 300 members.",
   );
Output: 7

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This is just a matter of using split to parse the sentences of each list to words, then counting the words,
then using List::Util 'max' to find the maximum word count of any sentence in the list. Something like this:
my $max = max map {scalar split /[ .]+/, $_} @sentences;

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
double-quoted array of arrays of single-quoted sentences in proper Perl syntax, apostrophes escaped, like so:
./ch-1.pl "(['I go.', 'She ran home.', 'I ate seven hot dogs.'],['She sat.', 'I didn\'t sit.'])"

Output is to STDOUT and will be each list of sentences, followed by max word count.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRELIMINARIES:
use v5.36;
use strict;
use warnings;
use utf8;
use Sys::Binmode;
use Time::HiRes 'time';
use List::Util  'max';
$"=', ';

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Start timer:
my $t0 = time;

# Default inputs:
my @lists =
(
   [
      "Perl and Raku belong to the same family.",
      "I love Perl.",
      "The Perl and Raku Conference.",
   ],
   [
      "The Weekly Challenge.",
      "Python is the most popular guest language.",
      "Team PWC has over 300 members.",
   ],
);

# Non-default inputs:
if (@ARGV) {@lists = eval($ARGV[0]);}

# Main loop:
for my $sentences (@lists) {
   my $max = max map {scalar split /[ .]+/, $_} @$sentences;
   say '';
   say 'Sentences:';
   say for @$sentences;
   say "Max word count = $max";
}

# Determine and print execution time:
my $µs = 1000000 * (time - $t0);
printf("\nExecution time was %.0fµs.\n", $µs);
