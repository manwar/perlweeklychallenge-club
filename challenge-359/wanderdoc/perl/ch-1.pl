#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a positive integer, $int.

Write a function that calculates the additive persistence of a positive integer and also return the digital root.

    Digital root is the recursive sum of all digits in a number until a single digit is obtained.

    Additive persistence is the number of times you need to sum the digits to reach a single digit.

Example 1

Input: $int = 38
Output: Persistence  = 2
        Digital Root = 2

38 => 3 + 8 => 11
11 => 1 + 1 => 2


Example 2

Input: $int = 7
Output: Persistence  = 0
        Digital Root = 7

Example 3

Input: $int = 999
Output: Persistence  = 2
        Digital Root = 9

999 => 9 + 9 + 9 => 27
27  => 2 + 7 => 9



Example 4
Input: $int = 1999999999
Output: Persistence  = 3
        Digital Root = 1

1999999999 => 1 + 9 + 9 + 9 + 9 + 9 + 9 + 9 + 9 + 9 => 82
82 => 8 + 2 => 10
10 => 1 + 0 => 1


Example 5

Input: $int = 101010
Output: Persistence  = 1
        Digital Root = 3

101010 => 1 + 0 + 1 + 0 + 1 + 0 => 3

=cut





use List::Util qw(sum);
use Test2::V0 -no_srand => 1;

is([digital_root(38)], [2, 2], 'Example 1');
is([digital_root(7)], [0, 7], 'Example 2');
is([digital_root(999)], [2, 9], 'Example 3');
is([digital_root(1999999999)], [3, 1], 'Example 4');
is([digital_root(101010)], [1, 3], 'Example 5');
done_testing();

sub digital_root
{
     my $int = $_[0];
     my $persistence = 0;
     my $digital_root = $int;
     while ( $digital_root > 9 )
     {
          $digital_root = sum(split(//, $digital_root));
          $persistence++;
     }
     return ( $persistence, $digital_root );
}
