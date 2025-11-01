#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an integer array @ints where each element is either a positive integer or -1.
We process the array from left to right while maintaining two lists:

@seen: stores previously seen positive integers (newest at the front)
@ans: stores the answers for each -1

Rules:

If $ints[i] is a positive number -> insert it at the front of @seen
If $ints[i] is -1:

Let $x be how many -1s in a row we’ve seen before this one.

If $x < len(@seen) -> append seen[x] to @ans

Else -> append -1 to @ans

At the end, return @ans.

Example 1

Input: @ints = (5, -1, -1)
Output: (5, -1)

@seen = (5)
First  -1: @ans = (5)
Second -1: @ans = (5, -1)


Example 2

Input: @ints = (3, 7, -1, -1, -1)
Output: (7, 3, -1)

@seen = (3, 7)
First  -1: @ans = (7)
Second -1: @ans = (7, 3)
Third  -1: @ans = (7, 3, -1)


Example 3

Input: @ints = (2, -1, 4, -1, -1)
Output: (2, 4, 2)


Example 4

Input: @ints = (10, 20, -1, 30, -1, -1)
Output: (20, 30, 20)


Example 5

Input: @ints = (-1, -1, 5, -1)
Output: (-1, -1, 5)

=cut

use Test2::V0 -no_srand => 1;



is([last_visitor(5, -1, -1)], [5, -1], 'Example 1');
is([last_visitor(3, 7, -1, -1, -1)], [7, 3, -1], 'Example 2');
is([last_visitor(2, -1, 4, -1, -1)], [2, 4, 2], 'Example 3');
is([last_visitor(10, 20, -1, 30, -1, -1)], [20, 30, 20], 'Example 4');
is([last_visitor(-1, -1, 5, -1)], [-1, -1, 5], 'Example 5');
done_testing();

sub last_visitor
{
     my @arr = @_;
     my (@seen, @ans);
     my $prev_int;
     my $x = 0;
     for my $int ( @arr )
     {
          if ( $int > 0 )
          {
               unshift @seen, $int;
               $x = 0;
          }
          elsif ( $int == -1 )
          {
               push @ans, $x < scalar(@seen) ? $seen[$x] : $int;
               if ( defined($prev_int) and $prev_int == -1 )
               {
                    $x++;
               }
               else
               {
                    $x = 1;
               }
          }
          $prev_int = $int;
     }
     return @ans;
}
