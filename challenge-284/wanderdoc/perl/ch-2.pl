#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given two list of integers, @list1 and @list2. The elements in the @list2 are distinct and also in the @list1.

Write a script to sort the elements in the @list1 such that the relative order of items in @list1 is same as in the @list2. Elements that is missing in @list2 should be placed at the end of @list1 in ascending order.
Example 1

Input: @list1 = (2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5)
       @list2 = (2, 1, 4, 3, 5, 6)
Ouput: (2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9)

Example 2

Input: @list1 = (3, 3, 4, 6, 2, 4, 2, 1, 3)
       @list2 = (1, 3, 2)
Ouput: (1, 3, 3, 3, 2, 2, 4, 4, 6)

Example 3

Input: @list1 = (3, 0, 5, 0, 2, 1, 4, 1, 1)
       @list2 = (1, 0, 3, 2)
Ouput: (1, 1, 1, 0, 0, 3, 2, 4, 5)
=cut

use Array::Utils qw(:all);
use Test2::V0;


is(relative_sort([2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5], [2, 1, 4, 3, 5, 6]),
     [2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9], 'Example 1');
is(relative_sort([3, 3, 4, 6, 2, 4, 2, 1, 3], [1, 3, 2]),
     [1, 3, 3, 3, 2, 2, 4, 4, 6], 'Example 2');
is(relative_sort([3, 0, 5, 0, 2, 1, 4, 1, 1], [1, 0, 3, 2]),
     [1, 1, 1, 0, 0, 3, 2, 4, 5], 'Example 3');
done_testing();


sub relative_sort
{
     my ($aref_1, $aref_2) = @_;
     my @a_minus_b = sort { $a <=> $b } array_minus(@$aref_1, @$aref_2);
     my %positions = map { $aref_2->[$_], $_ } 0 .. $#$aref_2;
     my $counter = $#$aref_2 + 1;
     for my $elm (@a_minus_b)
     {
          $positions{$elm} = $counter++;
     }
     return [sort { $positions{$a} <=> $positions{$b} } @$aref_1];
}