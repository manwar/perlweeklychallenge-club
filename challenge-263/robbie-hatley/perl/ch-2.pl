#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 263-2,
written by Robbie Hatley on Tue Apr 02, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 263-2: Merge Items
Submitted by: Mohammad Sajid Anwar
You are given two 2-D array of positive integers, $items1 and
$items2 where element is pair of (item_id, item_quantity).
Write a script to return the merged items.

Example 1:
Input: $items1 = [ [1,1], [2,1], [3,2] ]
       $items2 = [ [2,2], [1,3] ]
Output: [ [1,4], [2,3], [3,2] ]
Item id (1) appears 2 times: [1,1] and [1,3]. Merged item now (1,4)
Item id (2) appears 2 times: [2,1] and [2,2]. Merged item now (2,3)
Item id (3) appears 1 time: [3,2]

Example 2:
Input: $items1 = [ [1,2], [2,3], [1,3], [3,2] ]
       $items2 = [ [3,1], [1,3] ]
Output: [ [1,8], [2,3], [3,3] ]

Example 3:
Input: $items1 = [ [1,1], [2,2], [3,3] ]
       $items2 = [ [2,3], [2,4] ]
Output: [ [1,1], [2,9], [3,3] ]

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll make a hash with keys being "item_id" and values being "item_quanity". For each pair, I'll increment the
value of key "item_id" by amount "item_quantity".

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of arrays of 2-element arrays of positive integers, in proper Perl syntax:
./ch-2.pl '( [ [[1,8],[2,6]] , [[3,7],[2,4]] ] , [ [[1,1],[2,1]] , [[3,1],[4,1]] ] )'
The inner-most 2-element arrays will be construed as ordered [key,value] pairs.
The second-inner-most arrays are lists of key,value pairs.
The third-inner-most arrays are collections of such lists which are to be merged.
The outer-most array is the set of all such collections to be processed.

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

use v5.38;
sub merge_items (@lists) {
   # Make a hash of quantities keyed by id:
   my %items;
   # For each item (that is, for each (id,quantity) pair) in each list,
   # add its quantity to the quantity for the corresponding id in the hash:
   foreach my $list (@lists) {
      foreach my $item (@$list) {
         $items{$$item[0]} += $$item[1];
      }
   }
   # Finally, return a list of all (id,quantity) pairs from the hash,
   # sorted by the numeric values of the keys:
   return map {[$_,$items{$_}]} sort {$a <=> $b} keys %items;
}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 Input:
   [
      [ [1,1], [2,1], [3,2] ],
      [ [2,2], [1,3]        ],
   ],
   # Expected Output: [ [1,4], [2,3], [3,2] ]

   # Example 2 Input:
   [
      [ [1,2], [2,3], [1,3], [3,2] ],
      [ [3,1], [1,3]               ],
   ],
   # Expected Output: [ [1,8], [2,3], [3,3] ]

   # Example 3 Input:
   [
      [ [1,1], [2,2], [3,3] ],
      [ [2,3], [2,4]        ],
   ],
   # Expected Output: [ [1,1], [2,9], [3,3] ]
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $aref (@arrays) {
   say '';
   my @lists = @$aref;
   say 'Original lists of items:';
   say '[ ' , join(', ', map {'[' . join(',', @$_) . ']'}         @$_        ) , ' ]' for @lists ;
   say 'Merged list:';
   say '[ ' , join(', ', map {'[' . join(',', @$_) . ']'} merge_items(@lists)) , ' ]'            ;
}
