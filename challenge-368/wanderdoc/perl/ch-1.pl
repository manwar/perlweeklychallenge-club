#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a given a string number and a character digit.

Write a script to remove exactly one occurrence of the given character digit from the given string number, resulting the decimal form is maximised.
Example 1

Input: $str = "15456", $char = "5"
Output: "1546"

Removing the second "5" is better because the digit following it (6) is
greater than 5. In the first case, 5 was followed by 4 (a decrease),
which makes the resulting number smaller.

Example 2

Input: $str = "7332", $char = "3"
Output: "732"

Example 3

Input: $str = "2231", $char = "2"
Output: "231"

Removing either "2" results in the same string here. By removing a "2",
we allow the "3" to move up into a higher decimal place.

Example 4

Input: $str = "543251", $char = "5"
Output: "54321"

If we remove the first "5", the number starts with 4. If we remove the
second "5", the number still starts with 5. Keeping the largest possible
digit in the highest place value is almost always the priority.

Example 5

Input: $str = "1921", $char = "1"
Output: "921"

=cut

use Test2::V0 -no_srand => 1;


is(make_it_bigger(15456, 5), 1546, "Example 1");
is(make_it_bigger(7332, 3), 732, "Example 2");
is(make_it_bigger(2231, 2), 231, "Example 3");
is(make_it_bigger(543251, 5), 54321, "Example 4");
is(make_it_bigger(1921, 1), 921, "Example 5");
done_testing();

sub make_it_bigger
{
     my ($str, $char) = @_;
     my $max = 0;
     while ( $str =~ /$char/g )
     {
          my $pos = pos($str);
          my $candidate = substr($str, 0, $pos - 1) . 
                          substr($str, $pos);
          $max = $candidate > $max ? $candidate : $max;
     }
     return $max;
}
