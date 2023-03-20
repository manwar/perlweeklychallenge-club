#! /bin/perl -CSDA

# This is a 120-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
# ¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय.    看的星星，知道你是爱。 麦藁雪、富士川町、山梨県。
# =======|=========|=========|=========|=========|=========|=========|=========|=========|=========|=========|=========|

########################################################################################################################
# '/d/rhe/PWCC/208/ch-1.pl'
# Robbie Hatley's Perl solution to The Weekly Challenge 208-1.
# Written by Robbie Hatley.
# Edit history:
# Sat Jun 05, 2021: Wrote it.
########################################################################################################################

use v5.36;
use strict;
use warnings;
$"=', ';
use Sys::Binmode;

# ======= INTRODUCTORY NOTES: ==========================================================================================

=pod

Task 1: Minimum Index Sum
Submitted by: Mohammad S Anwar
Write a script to find all common strings between a pair of lists of string with minimum index sum. If no common strings
are found, return an empty list.

Example 1:  Inputs: ("Perl", "Raku", "Love") and ("Raku", "Perl", "Hate")
            Output: ("Perl", "Raku")

Example 2:  Inputs: ("A", "B", "C") and ("D", "E", "F")
            Output: ()

Example 3:  Inputs: ("A", "B", "C") and ("C", "A", "B")
            Output: ("A")

=cut

# ======= INPUT/OUTPUT NOTES: ==========================================================================================

=pod

Input is from built-in array of pairs of arrays or from @ARGV. If using @ARGV, the input should be one 'single-quoted'
string consisting of an array of arrays of two arrays of strings, in valid Perl syntax, such as:
./ch-1.pl '([["dog","cow","pig"],["cow","rat","bad"]],[["3","7","9"],["5","4","2"]])'

Output is to STDOUT and will be an array (which may be empty) of common strings with minimum index sum.

=cut

# ======= INPUTS: ======================================================================================================

# Default Inputs:
my @arrays = 
(
   [["Perl", "Raku", "Love"],["Raku", "Perl", "Hate"]],
   [[ "A"  ,  "B"  ,  "C"  ],[ "D"  ,  "E"  ,  "F"  ]],
   [[ "A"  ,  "B"  ,  "C"  ],[ "C"  ,  "A"  ,  "B"  ]],
   [["dog" , "cow" , "pig" ],["cow" , "rat" , "bad" ]],
   [[ "3"  ,  "7"  ,  "9"  ],[ "5"  ,  "4"  ,  "2"  ]]
);

# Non-Default Inputs:
if (@ARGV) {@arrays=eval($ARGV[0])}

# ======= MAIN BODY OF PROGRAM: ========================================================================================

for (@arrays){
   say '';
   my @List1 = @{$_->[0]};
   my @List2 = @{$_->[1]};
   say "List1 = @List1";
   say "List2 = @List2";
   my @sums;
   # Scan for common strings between the two lists, and store each with its index sum in @sums:
   for    ( my $i = 0 ; $i <= $#List1 ; ++$i ){
      for ( my $j = 0 ; $j <= $#List2 ; ++$j ){
         if ( $List1[$i] eq $List2[$j] ){
            push @sums, [$List1[$i],$i+$j]}}}
   # Get list of [value,index-sum] pairs sorted by increasing index sum:
   my @sorted = sort {$a->[1]<=>$b->[1]} @sums;
   # Get list of items with least index sum:
   my @least;
   for ( my $k = 0 ; $k <= $#sorted ; ++$k ){
      last if $k>0 && $sorted[$k]->[1]>$sorted[$k-1]->[1];
      push @least, $sorted[$k]->[0]}
   say "Common items with least index sum = (@least)"}