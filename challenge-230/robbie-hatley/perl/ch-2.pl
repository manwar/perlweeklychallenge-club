#! /bin/perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 230-2.
Written by Robbie Hatley on Wed Aug 16, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 2: Count Words
Submitted by: Mohammad S Anwar
You are given an array of words made up of alphabetic characters and a prefix. Write a script to return the
count of words that starts with the given prefix.

Example 1:
Input: @words  = ("pay", "attention", "practice", "attend"); $prefix = "at";
Ouput: 2
Two words "attention" and "attend" starts with the given prefix "at".

Example 2:
Input: @words  = ("janet", "julia", "java", "javascript"); $prefix = "ja";
Ouput: 3
Three words "janet", "java" and "javascript" starts with the given prefix "ja".

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This calls for the use of a regular expression:
$word =~ m/^$prefix/ and ++$count;

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
double-quoted array of arrays of single-quoted strings, apostrophes escaped, in proper Perl syntax, with the
last element of each inner array being a "prefix" to be looked-for at the beginning of the other elements,
like so:
./ch-2.pl "(['vinca', 'petunia', 'victory', 'vi'], ['puppet', 'pupusa', 'puppy', 'putrid', 'pu'])"

Output is to STDOUT and will be each input array followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRELIMINARIES:

use v5.38;
use strict;
use warnings;
use utf8;
use Sys::Binmode;
use Time::HiRes 'time';
$"=', ';

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Start timer:
my $t0 = time;

# Default inputs:
my @arrays =
(
   ["pay", "attention", "practice", "attend", "at"],
   ["janet", "julia", "java", "javascript", "ja"],
);

# Non-default inputs:
@arrays = eval($ARGV[0]) if @ARGV;

# Main loop:
for my $aref (@arrays) {
   say '';
   my @array = @$aref;
   my $prefix = pop @array;
   my $count = 0;
   map {/^$prefix/ and ++$count} @array;
   say "Array  = (@array)";
   say "Prefix = $prefix";
   say "$count elements start with given prefix.";
}

# Determine and print execution time:
my $µs = 1000000 * (time - $t0);
printf("\nExecution time was %.0fµs.\n", $µs);
