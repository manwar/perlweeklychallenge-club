#! /bin/perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
ch-1.pl
Solutions in Perl for The Weekly Challenge 220-1.
Written by Robbie Hatley on Wed Jun 07, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 1: Common Characters
Submitted by: Mohammad S Anwar
You are given a list of words. Write a script to return the list of common characters (sorted alphabetically)
found in every word of the given list.
Example 1: Input = ("Perl", "Rust", "Raku")   Output = ("r")
Example 2: Input = ("love", "live", "leave")  Output = ("e", "l", "v")

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I used this procedure:
1. Get case-folded fully-composed version of array.
2. Get deduped sorted list of all characters used.
3. Push each character appearing in all words onto array of "common characters".

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays in proper Perl syntax, like so:
./ch-1.pl '(["horse", "deer", "meercat"], ["cow", "wolf", "wool"])'

Output is to STDOUT and will be each input array, followed by common characters.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRELIMINARIES:
use v5.36;
use strict;
use warnings;
use utf8;
use Sys::Binmode;
use Time::HiRes 'time';
use List::Util 'uniq';
use Unicode::Normalize 'NFC';
$"=', ';

# ------------------------------------------------------------------------------------------------------------
# SUBROUTINES:
sub common_chars($aref) {
   my $fref = [map {fc NFC $_} @$aref];              # case-folded composed version of input
   my $lref = [uniq sort map {split //, $_} @$fref]; # sorted list of unique characters used
   my @common;                                       # array of common characters
   CHAR: for my $char (@$lref) {                     # for each character
      WORD: for my $word (@$fref) {                  #    for each word
         if ($word !~ m/$char/) {                    #       if word doesn't match character
            next CHAR;}}                             #          skip to next character
      push @common, $char;}                          #    else push character onto right end of @common
   return @common;}                                  # return results

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
my $t0 = time;
my @arrays =
(
   ["Perl", "Rust", "Raku"],                         # default inputs
   ["love", "live", "leave"],
);
if (@ARGV) {@arrays = eval($ARGV[0]);}               # non-default inputs
for my $aref (@arrays) {                             # for each input array
   say '';
   my $cref = [common_chars($aref)];                 # get common characters
   say "original array    = (@$aref)";               # print array
   say "common characters = (@$cref)";               # print common characters
}
my $µs = 1000000 * (time - $t0);                     # get   execution µs
printf("\nExecution time was %.3fµs.\n", $µs);       # print execution µs
