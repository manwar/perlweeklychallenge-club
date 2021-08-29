#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a list of intervals.

Write a script to find out if the current interval conflicts with any of the previous intervals.
Example

Input: @Intervals = [ (1,4), (3,5), (6,8), (12, 13), (3,20) ]
Output: [ (3,5), (3,20) ]

    - The 1st interval (1,4) do not have any previous intervals to compare with, so skip it.
    - The 2nd interval (3,5) does conflict with previous interval (1,4).
    - The 3rd interval (6,8) do not conflicts with any of the previous intervals (1,4) and (3,5), so skip it.
    - The 4th interval (12,13) again do not conflicts with any of the previous intervals (1,4), (3,5) and (6,8), so skip it.
    - The 5th interval (3,20) conflicts with the first interval (1,4).

Input: @Intervals = [ (3,4), (5,7), (6,9), (10, 12), (13,15) ]
Output: [ (6,9) ]

    - The 1st interval (3,4) do not have any previous intervals to compare with, so skip it.
    - The 2nd interval (5,7) do not conflicts with the previous interval (3,4), so skip it.
    - The 3rd interval (6,9) does conflict with one of the previous intervals (5,7).
    - The 4th interval (10,12) do not conflicts with any of the previous intervals (3,4), (5,7) and (6,9), so skip it.
    - The 5th interval (13,15) do not conflicts with any of the previous intervals (3,4), (5,7), (6,9) and (10,12), so skip it.

=cut





sub find_conflicts
{
     my $aref = $_[0];
     my %output;


     for my $idx_1 ( 1 .. $#$aref ) # no conflict at position 0.
     {
          for my $idx_2 ( 0 .. $idx_1 - 1 )
          {

               if ( ($aref->[$idx_1][0] < $aref->[$idx_2][0] and 
                     $aref->[$idx_1][1] < $aref->[$idx_2][1] and 
                     $aref->[$idx_1][1] < $aref->[$idx_2][0]) 

                         or

                    ($aref->[$idx_1][0] > $aref->[$idx_2][0] and 
                     $aref->[$idx_1][1] > $aref->[$idx_2][1] and 
                     $aref->[$idx_1][0] > $aref->[$idx_2][1])
                    )
               {
                    next;

               }
               else
               {
                    $output{join(", ",@{$aref->[$idx_1]})} = undef;
               }
          }
     }


     return [ sort { (split(/, /, $a))[0] <=> (split(/, /, $b))[0] or
                     (split(/, /, $a))[1] <=> (split(/, /, $b))[1] } keys %output];

}

my $result = find_conflicts([ [1,4], [3,5], [6,8], [12, 13], [3,20] ]);
print join("", "(",join("), (", @$result), ")"), $/;
$result = find_conflicts([ [3,4], [5,7], [6,9], [10, 12], [13,15] ]);
print join("", "(",join("), (", @$result), ")"), $/;

