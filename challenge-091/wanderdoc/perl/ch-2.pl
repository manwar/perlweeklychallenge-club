#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of positive numbers @N, where value at each index determines how far you are allowed to jump further. Write a script to decide if you can jump to the last index. Print 1 if you are able to reach the last index otherwise 0.
Example 1: Input: @N = (1, 2, 1, 2) Output: 1 as we jump one place from index 0 and then two places from index 1 to reach the last index.
Example 2: Input: @N = (2,1,1,0,2) Output: 0 it is impossible to reach the last index. as we jump two places from index 0 to reach index 2, followed by one place jump from index 2 to reach the index 3. once you reached the index 3, you can't go any further because you can only jump 0 position further.
=cut





use Test::More;






sub jump
{
     my @arr = @_; 
     die "Array with at least two elements required!$/" if $#arr == 0;

     my $i = 0;
     while ( $i < $#arr )
     {
          my $old_i = $i;
          $i += $arr[$i];
          return 0 if ($i == $old_i or $i > $#arr); 
     }
     return 1;
}





is(jump(1, 2, 1, 2),          1, 'Example 1');
is(jump(2, 1, 1, 0, 2),       0, 'Example 2');
is(jump(1, 3, 2),             0, 'Example 3');
is(jump(1, 1, 3, 2, 1, 0),    1, 'Example 4');
is(jump(1, 0),                1, 'Example 5');
is(jump(0, 1),                0, 'Example 5');
done_testing();