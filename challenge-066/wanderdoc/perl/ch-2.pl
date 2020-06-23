#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an integer $N.

Write a script to check if the given number can be expressed as mn where m and n are positive integers. Otherwise print 0.
Example 1:

For given $N = 9, it should print 3^2.
Example 2:

For given $N = 45, it should print 0.
=cut



use Test::More;

is(check_power(9), '3^2', '9 can');
is(check_power(45), 0, '45 cannot');
is(check_power(387420489), '3^18', '387420489 can');
is(check_power(322687697779), '19^9', '322687697779 can');
is(check_power(982451653), 0, '982451653 cannot');

is(check_power(312079600999), '199^5', '312079600999 can');
is(check_power(100000004987), 0, '100000004987 cannot');
is(check_power(584318301411328), '22^11', '584318301411328 can');

done_testing();
sub check_power
{
     my $num = $_[0];
     for my $i ( 2 .. sqrt($num) )
     {

          my $result = $i;


          my $counter = 1;
          while ( $result < $num )
          {

               $result *= $i;
               $counter++;
               return return $i . '^' . $counter if $result == $num;
          }

     }
     return 0;
}