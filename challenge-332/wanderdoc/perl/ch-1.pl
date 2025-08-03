#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a date in the format YYYY-MM-DD.
Write a script to convert it into binary date.

Example 1

Input: $date = "2025-07-26"
Output: "11111101001-111-11010"


Example 2

Input: $date = "2000-02-02"
Output: "11111010000-10-10"


Example 3

Input: $date = "2024-12-31"
Output: "11111101000-1100-11111"

=cut

use Test2::V0 -no_srand => 1;

is(binary_date('2025-07-26'), '11111101001-111-11010', 'Example 1');
is(binary_date('2000-02-02'), '11111010000-10-10', 'Example 2');
is(binary_date('2024-12-31'), '11111101000-1100-11111', 'Example 3');
done_testing();

sub binary_date
{
     my $str = $_[0];
     return join('-',
          map { sprintf("%b", $_) }
          split(/\-/, $str, -1));
     
     
}
