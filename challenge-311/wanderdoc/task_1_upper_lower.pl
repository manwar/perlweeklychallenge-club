#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string consists of english letters only.

Write a script to convert lower case to upper and upper case to lower in the given string.
Example 1

Input: $str = "pERl"
Output: "PerL"

Example 2

Input: $str = "rakU"
Output: "RAKu"

Example 3

Input: $str = "PyThOn"
Output: "pYtHoN"
=cut

use Test2::V0 -no_srand => 1;

is(upper_lower('pERl'), 'PerL', 'Example 1');
is(upper_lower('rakU'), 'RAKu', 'Example 2');
is(upper_lower('PyThOn'), 'pYtHoN', 'Example 3');
done_testing();

sub upper_lower
{
     my $str = $_[0];
     # $str =~ s/(\p{Uppercase}) | (\p{Lowercase}) /defined $1 ? lc $1 : uc $2/xeg;
     $str =~ tr/A-Za-z/a-zA-Z/;
     return $str;
}
