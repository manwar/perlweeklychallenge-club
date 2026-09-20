#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of box dimensions.

Write a script to determine the maximum number of these boxes that can fit inside each other in a single stack. For a box to fit inside another, it must be smaller in both dimensions.
Example 1

Input: @boxes = ([1, 3], [3, 5], [6, 8], [2, 4])
Output: 4

Sort by width ascending: ([1, 3], [2, 4], [3, 5], [6, 8])
Extract heights: [3, 4, 5, 8]
[1, 3] -> [2, 4] -> [3, 5] -> [6, 8]

Example 2

Input: @boxes = ([4, 5], [4, 6], [6, 7], [2, 3], [4, 3])
Output: 3

Sort by width ascending: ([2, 3], [4, 6], [4, 5], [4, 3], [6, 7])
Extract heights: (3, 6, 5, 3, 7)
[2, 3] -> [4, 5] -> [6, 7]

Example 3

Input: @boxes = ([5, 5], [5, 5], [5, 5])
Output: 1

Sort by width ascending: ([5, 5], [5, 5], [5, 5])
Extract heights: (5, 5, 5)
[5, 5]

Example 4

Input: @boxes = ([2, 100], [3, 200], [4, 300], [5, 50], [5, 400])
Output: 4

Sort by width ascending: ([2, 100], [3, 200], [4, 300], [5, 400], [5, 50])
Extract heights: (100, 200, 300, 400, 50)
[2, 100] -> [3, 200] -> [4, 300] -> [5, 400]

Example 5

Input: @boxes = ([10, 20], [15, 10], [20, 30], [12, 18], [16, 25])
Output: 3

Sort by width ascending: ([10, 20], [12, 18], [15, 10], [16, 25], [20, 30])
Extract heights: (20, 18, 10, 25, 30)
[15, 10] -> [16, 25] -> [20, 30]
=cut





use List::Util qw(max);
use Test2::V0 -no_srand => 1;
is(arrange_boxes([1, 3], [3, 5], [6, 8], [2, 4]), 4, 'Example 1');
is(arrange_boxes([4, 5], [4, 6], [6, 7], [2, 3], [4, 3]), 3, 'Example 2');
is(arrange_boxes([5, 5], [5, 5], [5, 5]), 1, 'Example 3');
is(arrange_boxes([2, 100], [3, 200], [4, 300], [5, 50], [5, 400]), 4, 'Example 4');
is(arrange_boxes([10, 20], [15, 10], [20, 30], [12, 18], [16, 25]), 3, 'Example 5');
done_testing();


sub arrange_boxes
{
     my @boxes = @_;
     @boxes = sort { $a->[0] <=> $b->[0] or $a->[1] <=> $b->[1] } @boxes;
     my $start = 0;
     my @output;
     my $idx = 0;

     while ( $idx < @boxes )
     {
          my $this = $boxes[$idx];
          BOX: for my $j ( $idx + 1 .. $#boxes )
          {
               my $that = $boxes[$j];
               my $last = defined $output[$idx] ?
                    $boxes[$output[$idx]->[-1]] : $this;
               if ( $this->[0] < $that->[0] and $this->[1] < $that->[1] 
                    and $last->[0] < $that->[0] and $last->[1] < $that->[1]
                    )
               {
                    push @{$output[$idx]}, $j;
                    next BOX;
               }
          }
          $idx++;
     }

     my @sizes = 
          map { scalar @{$output[0]} + 1 }
          grep { defined $output[$_] } 0 .. $#output;
     return max(@sizes) // 1;
}
