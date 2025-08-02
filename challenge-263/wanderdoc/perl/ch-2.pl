#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given two 2-D array of positive integers, $items1 and $items2 where element is pair of (item_id, item_quantity). Write a script to return the merged items.
Example 1
Input: $items1 = [ [1,1], [2,1], [3,2] ] $items2 = [ [2,2], [1,3] ]
Output: [ [1,4], [2,3], [3,2] ]
Item id (1) appears 2 times: [1,1] and [1,3]. Merged item now (1,4)
Item id (2) appears 2 times: [2,1] and [2,2]. Merged item now (2,3)
Item id (3) appears 1 time: [3,2]

Example 2
Input: $items1 = [ [1,2], [2,3], [1,3], [3,2] ] $items2 = [ [3,1], [1,3] ]
Output: [ [1,8], [2,3], [3,3] ]

Example 3
Input: $items1 = [ [1,1], [2,2], [3,3] ] $items2 = [ [2,3], [2,4] ]
Output: [ [1,1], [2,9], [3,3] ]
=cut

use Sort::Key qw(nkeysort);
use Test2::V0;


is(merge_items([ [1,1], [2,1], [3,2] ], [ [2,2], [1,3] ]), 
     [ [1,4], [2,3], [3,2] ], 'Example 1');
is(merge_items([ [1,2], [2,3], [1,3], [3,2] ], [ [3,1], [1,3] ]), 
     [ [1,8], [2,3], [3,3] ], 'Example 2');
is(merge_items([ [1,1], [2,2], [3,3] ], [ [2,3], [2,4] ]), 
     [ [1,1], [2,9], [3,3] ], 'Example 3');     
     done_testing();

sub merge_items
{
     use integer;
     my @arefs = @_; 
     my %merge;
     for my $paar ( map { @$_ } @arefs )
     {
          $merge{ $paar->[0] } += $paar->[1];
     }
     return [ map { [$_, $merge{$_}] } nkeysort{$_} keys %merge ];
}
