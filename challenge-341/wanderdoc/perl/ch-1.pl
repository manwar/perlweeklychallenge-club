#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string containing English letters only and also you are given broken keys.
Write a script to return the total words in the given sentence can be typed completely.

Example 1

Input: $str = 'Hello World', @keys = ('d')
Output: 1

With broken key 'd', we can only type the word 'Hello'.


Example 2

Input: $str = 'apple banana cherry', @keys = ('a', 'e')
Output: 0


Example 3

Input: $str = 'Coding is fun', @keys = ()
Output: 3

No keys broken.


Example 4

Input: $str = 'The Weekly Challenge', @keys = ('a','b')
Output: 2


Example 5

Input: $str = 'Perl and Python', @keys = ('p')
Output: 1

=cut


use Test2::V0 -no_srand => 1;
is(can_print('Hello World', ['d']), 1, 'Example 1');
is(can_print('apple banana cherry', ['a', 'e']), 0, 'Example 2');
is(can_print('coding is fun', []), 3, 'Example 3');
is(can_print('The Weekly Challenge', ['a','b']), 2, 'Example 4');
is(can_print('Perl and Python', ['p']), 1, 'Example 5');
done_testing();




sub can_print
{
     my ($str, $keys_aref) = @_;
     my $keys_str = join('|', @$keys_aref);
     my $keys_re = length($keys_str) ? qr/$keys_str/i : qr/ /; 
     return scalar(grep {!/$keys_re/} split(/\s/, $str));
}
