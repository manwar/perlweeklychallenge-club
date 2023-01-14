#! /usr/bin/perl

# /d/rhe/PWCC/199/ch-1 
# "Good Pairs"

=pod

Task 1: Good Pairs
Submitted by: Mohammad S Anwar

You are given a list of integers, @list. Write a script to find 
the total count of "Good Pairs". A pair (i, j) is called "good" 
if list[i] == list[j] and i < j.

Example 1:  Input: (1,2,3,1,1,3)  Output: 4
Example 2:  Input: (1,2,3)        Output: 0
Example 3:  Input: (1,1,1,1)      Output: 6

=cut

# IO NOTES:

# NOTE: Input is via built-in array of arrays, or via @ARGV.
#       If using @ARGV, input should be a space-separated list
#       of integers.

# NOTE: Output is to stdout and will be the input list followed
#       by number of Good Pairs found.

# PRELIMINARIES:

use v5.36;
$" = ', ';

# DEFAULT INPUT:
my @arrays = ([1,2,3,1,1,3],[1,2,3],[1,1,1,1]);

# NON-DEFAULT INPUT:
if (@ARGV) {@arrays = ([@ARGV])}

# MAIN BODY OF SCRIPT:
for (@arrays){
   my @array = @{$_};
   my @good;
   for    ( my $i =    0   ; $i <= $#array - 1 ; ++$i ){
      for ( my $j = $i + 1 ; $j <= $#array - 0 ; ++$j ){
         if ( $array[$i] == $array[$j] ){
            push @good, [$i, $j];}}}
   my $good_count = scalar(@good);
   say '';
   say "list = (@array)";
   say "Found $good_count \"Good Pairs\" of list indices:";
   say "(@{$_})" for @good}