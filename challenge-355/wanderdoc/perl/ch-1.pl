#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a positive integer, $int.

Write a script to add thousand separator, , and return as string.
Example 1

Input: $int = 123
Output: "123"


Example 2

Input: $int = 1234
Output: "1,234"


Example 3

Input: $int = 1000000
Output: "1,000,000"


Example 4

Input: $int = 1
Output: "1"


Example 5

Input: $int = 12345
Output: "12,345"

=cut


use Test2::V0 -no_srand => 1;
is(thousand_separator(123), 123, 'Example 1');
is(thousand_separator(1234), '1,234', 'Example 2');
is(thousand_separator(1000000), '1,000,000', 'Example 3');
is(thousand_separator(1), 1, 'Example 4');
is(thousand_separator(12345), '12,345', 'Example 5');

done_testing();

sub thousand_separator
{
     my $int = $_[0];
     while ( $int =~ s/(.*\d)(\d{3})/$1,$2/g )
     {
          1;
     }
     return $int;
}
