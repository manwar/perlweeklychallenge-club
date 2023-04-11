#! /bin/perl -CSDA

=pod

------------------------------------------------------------------------------------------
TITLE BLOCK:
ch-1.pl
Robbie Hatley's Perl solutions for The Weekly Challenge 212-1.
Written by Robbie Hatley on Mon Apr 10, 2023.

------------------------------------------------------------------------------------------
COLOPHON:
This is a 90-character-wide UTF-8 Perl-source-code text file with hard Unix line breaks.
¡Hablo Español! ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。
=========|=========|=========|=========|=========|=========|=========|=========|=========|

------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:

Task 2: Rearrange Groups
Submitted by: Mohammad S Anwar
You are given a list of integers and group size greater than zero. Write a script to split
the list into equal groups of the given size where integers are in sequential order. If it
can’t be done then print -1.

Example 1:  Input:  @list = (1,2,3,5,1,2,7,6,3) and $size = 3  
            Output: (1,2,3), (1,2,3), (5,6,7)

Example 2:  Input:  @list = (1,2,3) and $size = 2
            Output: -1

Example 3:  Input:  @list = (1,2,4,3,5,3) and $size = 3
            Output: (1,2,3), (3,4,5)

Example 4:  Input: @list = (1,5,2,6,4,7) and $size = 3
            Output: -1

------------------------------------------------------------------------------------------
PROBLEM NOTES:

Let us assume these axioms:

1. "Sequential order" of a sequence of integers means "consecutive integers".
2. "Equal groups" means "subsets with equal cardinality".
3. "Groups" means "parts of a partition".

Then those axioms imply the following theorems:

1. For a compliant partition to exist, the cardinality C of the original set must be
   divisible by $size.

2. For a partition to be compliant, it MUST contain one part which starts with the least
   element of the original set, because that element must be accounted for, and it can't
   be a "middle" or "last" element of a part because there are no lesser elements,
   therefore it must be the "least" element of a part.

3. The remaining parts of a compliant partition must obey the same principle as #2 above
   relative to the "remaining" elements of the original set

These theorems suggest an approach: 
1. Sort the original set in-situ.
2. If C is not divisible by $size, print -1 and stop.
3. Try to form a subset of cardinality C/$size consisting of consecutive integers starting
   with the least element. If this succeeds, remove those elements from the set; if this
   fails, print -1 and stop.
4. Keep applying step 3 to the remaining elements until we either print -1 or succeed in
   forming a compliant partition.

------------------------------------------------------------------------------------------
INPUT / OUTPUT NOTES:

Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument
which must be a 'single-quoted' array of arrays in proper Perl syntax, with each array
consisting of the sequence to be partitioned followed by the desired part size, like so:
./ch-2.pl '([2, -36, 5, -37, 4, -35, 3, -34, 4],[1,7,6,2,2])'

Output is to STDOUT and will be the input array and part size followed by either a
compliant partition or by "-1" if no compliant partition is possible.

=cut

# ======= PRELIMINARIES: =================================================================
# 
use v5.36;
use strict;
use warnings;
use utf8;
use Sys::Binmode;
use Time::HiRes 'time';
$"=', ';

# ======= SUBROUTINES: ===================================================================

sub consecutive_partition ($aref){
   my @set = @{$aref};
   my $size = pop @set;
   my $card = scalar @set;
   if ( 0 != $card % $size ){
      return "-1";
   }
   my $numpar = $card/$size;
   my @sorted = sort {$a<=>$b} @set;

   # Try to partition @sorted into $numpar parts:
   my @parts;
   for ( my $i = 0 ; $i < $numpar ; ++$i ){
      # Start-off the $i'th part with the least remaining element:
      push @{$parts[$i]}, shift @sorted;
      # Try to fill the part with $size consecutive integers from @sorted:
      for ( my $j = 0 ; $j <= $#sorted && scalar(@{$parts[$i]}) < $size ; ++$j ) {
         if    ( $sorted[$j]  < $parts[$i]->[-1]+1 ) {
            next;
         }
         elsif ( $sorted[$j] == $parts[$i]->[-1]+1 ) {
            push @{$parts[$i]}, splice @sorted, $j, 1;
            --$j;
            next;
         }
         elsif ( $sorted[$j]  > $parts[$i]->[-1]+1 ) {
            last;
         }
      }
      # If that failed, return "-1":
      if (scalar(@{$parts[$i]}) < $size) {return "-1"}
   }

   # If we get to here, we've made a valid partition of @sorted (and hence also a valid
   # partition of @set), so make and return the final "partition" string:
   my $partition = '(';
   for ( my $i = 0 ; $i < $numpar ; ++$i ){
      $partition .= "[@{$parts[$i]}]";
      if ($i < $numpar-1) {$partition .= ',';}
   }
   $partition .= ')';
   return $partition;
}

# ======= DEFAULT INPUTS: ================================================================

my @arrays = 
(
   [1,2,3,5,1,2,7,6,3,3],
   [1,2,3,2],
   [1,2,4,3,5,3,3],
   [1,5,2,6,4,7,3],
   [2,-36,5,-37,4,-35,3,-34,4],
   [1,7,6,2,2]
);

# ======= NON-DEFAULT INPUTS: ============================================================

if (@ARGV) {@arrays = eval($ARGV[0]);}

# ======= MAIN BODY OF PROGRAM: ==========================================================

{ # begin main
   my $t0 = time;
   for (@arrays){
      say '';
      say "array: (@$_[0..scalar(@{$_})-2])";
      say "psize: $$_[-1]";
      say "parts: ", consecutive_partition($_);
   }
   my $t1 = time; my $te = $t1 - $t0;
   say "\nExecution time was $te seconds.";
   exit 0;
} # end main
