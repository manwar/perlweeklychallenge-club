#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string and a width.

Write a script to return the string that centers the text within that width using asterisks * as padding.
Example 1

Input: $str = "Hi", $width = 5
Output: "*Hi**"

Text length = 2, Width = 5
Need 3 padding characters total
Left padding: 1 star, Right padding: 2 stars

Example 2

Input: $str = "Code", $width = 10
Output: "***Code***"

Text length = 4, Width = 10
Need 6 padding characters total
Left padding: 3 stars, Right padding: 3 stars

Example 3

Input: $str = "Hello", $width = 9
Output: "**Hello**"

Text length = 5, Width = 9
Need 4 padding characters total
Left padding: 2 stars, Right padding: 2 stars


Example 4

Input: $str = "Perl", $width = 4
Output: "Perl"

No padding needed


Example 5

Input: $str = "A", $width = 7
Output: "***A***"

Text length = 1, Width = 7
Need 6 padding characters total
Left padding: 3 stars, Right padding: 3 stars

Example 6

Input: $str = "", $width = 5
Output: "*****"

Text length = 0, Width = 5
Entire output is padding

=cut





use Test2::V0 -no_srand => 1;
is(padding("Hi", 5), '*Hi**', 'Example 1');
is(padding("Code", 10), '***Code***', 'Example 2');
is(padding("Hello", 9), '**Hello**', 'Example 3');
is(padding("Perl", 4), 'Perl', 'Example 4');
is(padding("A", 7), '***A***', 'Example 5');
is(padding("", 5), '*****', 'Example 6');
is(padding("Test", 3), 'Tes', 'Example 7');
done_testing();


sub padding
{
     my $str =   $_[0];
     my $width = $_[1];
     my $left = my $right = 0;
     my $padding = $width - length($str);
     if ( $padding > 0 )
     {
          $left = int($padding / 2);
          $right = $padding - $left;
     }
     else
     {
          return substr($str, 0, $width);
     }
     return join('', '*' x $left, $str, '*' x $right);
}
