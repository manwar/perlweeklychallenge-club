#! /bin/perl -CSDA

=pod

------------------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 120-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

------------------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
ch-1.pl
Robbie Hatley's Perl solutions for The Weekly Challenge 215-1.
Written by Robbie Hatley on Tue May 2, 2023.

------------------------------------------------------------------------------------------------------------------------
Task 1: Odd One Out
Submitted by: Mohammad S Anwar
You are given a list of words (alphabetic characters only) of same size. Write a script to remove all words not sorted
alphabetically and print the number of words in the list that are not alphabetically sorted.

Example 1:  Input: ('abc', 'xyz', 'tsu')  Output: 1
Example 2:  Input: ('rat', 'cab', 'dad')  Output: 3
Example 3:  Input: ( 'x',   'y',   'z' )  Output: 0

------------------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I think the simplest way to find unsorted words is to compare each $word to join(sort(split($word))).

------------------------------------------------------------------------------------------------------------------------
INPUT / OUTPUT NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a double-quoted
array of arrays in proper Perl syntax, with each inner array being a sequence of single-quoted words, like so:
./ch-1.pl "(['Tom', 'Bob', 'Sue'], ['Abe', 'Cor', 'Den'], [ 'and', 'for', 'you' ],)";

Output is to STDOUT and will be each word list followed by the number of unsorted words.

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
# SUBROUTINES:
sub is_unsorted ($word) {
   return fc $word ne fc join '', sort split //, $word;
}

# ----------------------------------------------------------------------------------------------------------------------
# DEFAULT INPUTS:
my @arrays =
(
   ['abc', 'xyz', 'tsu'],
   ['rat', 'cab', 'dad'],
   [ 'x',   'y',   'z' ],
);

# ----------------------------------------------------------------------------------------------------------------------
# NON-DEFAULT INPUTS:
if (@ARGV) {@arrays = eval($ARGV[0]);}

# ----------------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
{ # begin main
   my $t0 = time;
   foreach my $aref (@arrays) {
      my $unsorted=0;
      foreach my $word (@$aref) {
         if (is_unsorted($word)) {
            ++$unsorted;
         }
      }
      say '';
      say "word list: (@$aref)";
      say "unsorted:  $unsorted";
   }
   my $µs = 1000000 * (time - $t0);
   printf("\nExecution time was %.3fµs.\n", $µs);
   exit 0;
} # end main
