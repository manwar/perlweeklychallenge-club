#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a positive integer, $int, having 3 or more digits.

Write a script to return the good integer in the given integer or -1 if none found.

    A good integer is exactly three consecutive matching digits.

Example 1

Input: $int = 12344456
Output: "444"

Example 2

Input: $int = 1233334
Output: -1

Example 3

Input: $int = 10020003
Output: "000"


=cut

use Test2::V0;

is(good_integer(12344456), '444', 'Example 1');
is(good_integer(1233334), -1, 'Example 2');
is(good_integer(10020003), '000', 'Example 3');
is(good_integer(11122345), '111', 'Example 4');
is(good_integer(1112211122), -1, 'Example 5');
is(good_integer(1122333), '333', 'Example 6');
done_testing();



sub good_integer
{
     my $int = $_[0];
     my @matches;

     while ( $int =~ /((?<digit>\d)\k<digit>{2})/g )
     {
          push @matches, $1;
          pos($int) -= 2;
     }
     if ( scalar @matches == 1 )
     {
          return $matches[0];
     }
     return -1;
 }