#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string containing only lower case English letters and digits.
Write a script to replace every non-digit character with a space and then return all the distinct integers left.

Example 1

Input: $str = "the1weekly2challenge2"
Output: 1, 2

2 is appeared twice, so we count it one only.


Example 2

Input: $str = "go21od1lu5c7k"
Output: 21, 1, 5, 7


Example 3

Input: $str = "4p3e2r1l"
Output: 4, 3, 2, 1
=cut

use List::Util qw(uniq);
use Test2::V0 -no_srand => 1;
is(counter_integers('the1weekly2challenge2'), '1, 2', 'Example 1');
is(counter_integers('go21od1lu5c7k'), '21, 1, 5, 7', 'Example 2');
is(counter_integers('4p3e2r1l'), '4, 3, 2, 1', 'Example 3');
done_testing();


sub counter_integers
{
     my $str = $_[0];
     $str =~ s/[[:alpha:]]+/ /g;
     $str =~ s/(^ +| +$)//g;
     return join(", ", uniq(split(/ /, $str))); # no hash because of sequence order.
}
