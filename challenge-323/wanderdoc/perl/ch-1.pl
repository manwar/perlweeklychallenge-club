#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a list of operations.

Write a script to return the final value after performing the given operations in order. The initial value is always 0.

Possible Operations:
++x or x++: increment by 1
--x or x--: decrement by 1


Example 1

Input: @operations = ("--x", "x++", "x++")
Output: 1

Operation "--x" =>  0 - 1 => -1
Operation "x++" => -1 + 1 =>  0
Operation "x++" =>  0 + 1 =>  1


Example 2

Input: @operations = ("x++", "++x", "x++")
Output: 3


Example 3

Input: @operations = ("x++", "++x", "--x", "x--")
Output: 0

Operation "x++" => 0 + 1 => 1
Operation "++x" => 1 + 1 => 2
Operation "--x" => 2 - 1 => 1
Operation "x--" => 1 - 1 => 0

=cut

use Test2::V0 -no_srand => 1;

is(task1("--x", "x++", "x++"), 1, 'Example 1');
is(task1("x++", "++x", "x++"), 3, 'Example 2');
is(task1("x++", "++x", "--x", "x--"), 0, 'Example 3');
done_testing();

sub task1
{
     my @arr = @_;
     my $value = 0;
     for my $operator ( @arr )
     {
          if ($operator =~ /\+/)
          {
               $value++;
          }
          elsif ( $operator =~ /\-/ )
          {
               $value--;
          }
     }
     return $value;
}
