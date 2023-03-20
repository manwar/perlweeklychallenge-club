#! /bin/perl -CSDA

# This is a 120-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
# ¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय.    看的星星，知道你是爱。 麦藁雪、富士川町、山梨県。
# =======|=========|=========|=========|=========|=========|=========|=========|=========|=========|=========|=========|

########################################################################################################################
# '/d/rhe/PWCC/208/ch-2.pl'
# Robbie Hatley's Perl solution to The Weekly Challenge 208-2.
# Written by Robbie Hatley.
# Edit history:
# Wed Mar 15,  Jun 05, 2021: Wrote it.
########################################################################################################################

use v5.36;
use strict;
use warnings;
$"=', ';
use Sys::Binmode;

# ======= INTRODUCTORY NOTES: ==========================================================================================

=pod

Task 2: Duplicate and Missing
Submitted by: Mohammad S Anwar
Write a script to return the duplicate integer and missing integer in an array which supposedly has one missing integer
and one duplicate integer, or return -1 if the numbers of missing and duplicate integers are not both 1.
Example 1:  Input: (1,2,2,4)        Output: (2,3)
Example 2:  Input: (1,2,3,4)        Output: -1
Example 3:  Input: (1,2,3,3)        Output: (3,4)
TACIT ASSUMPTION WHICH IS LOGICALLY REQUIRED BY EXAMPLE 3 BUT IS NOT POINTED-OUT IN THE INSTRUCTIONS:
  1. If the greatest integer is a duplicate, and if the greatest integer is one-more-than the next-greatest,
     then assume that an invisible "missing" integer Xmax+1 exists.
TACIT ASSUMPTION WHICH IS IMPLIED-BY (BUT NOT REQUIRED-BY) EXAMPLE 3, TO PRESERVE SYMMETRY:
  2. If the smallest integer is a duplicate, and if the smallest integer is one-less-than the next-smallest,
     then assume that an invisible "missing" integer Xmin-1 exists.
Example 5:  Input: (5,-2,4,3,-1,4)  Output: (4,0)
Example 6:  Input: (-3,-6,-2,-2,-5) Output: -1 (more than one missing integer in this sequence)

=cut

# ======= INPUT/OUTPUT NOTES: ==========================================================================================

=pod

Input is either from built-in array of arrays or from @ARGV. If using @ARGV, the input should be one 'single-quoted'
string consisting of an array of arrays of integers, in valid Perl syntax, such as:
./ch-2.pl '([5,-2,4,3,-1,4],[-3,-6,-2,-2,-5])'

Output will be to STDOUT and will be the duplicate integer and missing integers (if there are one of each), 
or -1 (otherwise). Also output will be the original array, and arrays of any duplicate and missing integers found,
keeping in-mind the Xmin-1 and Xmax+1 rules logically-implied by Example 3 but not given in the instructions.

=cut

# ======= INPUTS: ======================================================================================================

# Default Inputs:
my @arrays = 
(
   [1,2,2,4],
   [1,2,3,4],
   [1,2,3,3],
   [5,-2,4,3,-1,4],
   [-3,-6,-2,-2,-5]
);

# Non-Default Inputs:
if (@ARGV) {@arrays=eval($ARGV[0])}

# ======= MAIN BODY OF PROGRAM: ========================================================================================

for (@arrays){
   say '';
   my @array  = @{$_};
   my @sorted = sort {$a<=>$b} @array;
   say "Array      = @sorted";
   my @dup = ();
   my @mis = ();
   # Scan for duplicate integers:
   for    ( my $i =    0   ; $i <= $#sorted-1 ; ++$i ){
      for ( my $j = $i + 1 ; $j <= $#sorted-0 ; ++$j ){
         if ( $sorted[$i] == $sorted[$j] ){
            # We found a duplicate, so push it to @dup:
            push @dup, $sorted[$i];
            # Enforce Tacit Assumption #1 re "missing greatest" (see Introductory Notes):
            if ( $#sorted-1 == $i && $#sorted-0 == $j && $sorted[$i] == $sorted[$i-1]+1 ){
               push @mis, $sorted[$j]+1;}
            # Enforce Tacit Assumption #2 re "missing least"    (see Introductory Notes):
            if ( 0 == $i && 1 == $j && $sorted[$j] == $sorted[$j+1]-1 ){
               push @mis, $sorted[$i]-1;}}}}
   # Scan for interior missing integers:
   for ( my $i = 1 ; $i <= $#sorted ; ++$i ){
      if ( $sorted[$i]-$sorted[$i-1]>1 ){
         push @mis, $_ for ($sorted[$i-1]+1..$sorted[$i]-1)}}
   # If we have exactly one duplicate integer and exactly one missing integer, queue those as being our primary output;
   # otherwise output "-1" for output instead:
   my $output;
   if ( scalar(@dup) == 1 && scalar(@mis) == 1 ) {$output = "($dup[0], $mis[0])"}
   else                                          {$output = "-1"}

   # Print outputs:
   say "Output     = $output";
   say "Duplicates = (@dup)";
   say "Missing    = (@mis)"}