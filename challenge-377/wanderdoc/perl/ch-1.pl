#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string.

Write a script to find whether any substring of length 2 is also present in the reverse of the given string.
Example 1

Input: $str = "abcba"
Output: true

Reverse of given string is "abcba".
The substring "ab" in original string is also present in the reverse string too.

Example 2

Input: $str = "racecar"
Output: true

The substring "ce" is present in both.

Example 3

Input: $str = "abcd"
Output: false

Example 4

Input: $str = "banana"
Output: true

The substring "an" is present in both.

Example 5

Input: $str = "hello"
Output: true

The substring "ll" is present in both.

=cut






use constant { true => 1, false => 0 };
use Test2::V0 -no_srand => 1;

is(reverse_existence('abcba'), true, 'Example 1');
is(reverse_existence('racecar'), true, 'Example 2');
is(reverse_existence('abcd'), false, 'Example 3');
is(reverse_existence('banana'), true, 'Example 4');
is(reverse_existence('hello'), true, 'Example 5');

done_testing();

sub reverse_existence
{
     my $str = $_[0];
     my $rev_str = reverse $str;

     for my $idx ( 0 .. length($str) - 2 )
     {
          if( index($rev_str, substr($str, $idx, 2)) != -1)
          {
               return true;
          }
     }
     return false;
}
