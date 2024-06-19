#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string, $str.

Write a script to return true if there is at least one b, and no a appears after the first b.
Example 1

Input: $str = "aabb"
Output: true

Example 2

Input: $str = "abab"
Output: false

Example 3

Input: $str = "aaa"
Output: false

Example 4

Input: $str = "bbb"
Output: true
=cut

use constant false => 0;
use constant true  => 1;

use Test2::V0;

is(b_after_a('aabb'), true, 'Example 1');
is(b_after_a('abab'), false, 'Example 2');
is(b_after_a('aaa'), false, 'Example 3');
is(b_after_a('bbb'), true, 'Example 4');
is(b_after_a('bbba'), true, 'Example 5'); # no a appears after the _first_ b
done_testing();

sub b_after_a
{
     my $string = $_[0];
     return ($string =~ /b/ and $string !~ /[^b]b(?=a)/) * 1;  
               # 'no a after _any_ b' would be: $string !~ /b(?=a)/
}