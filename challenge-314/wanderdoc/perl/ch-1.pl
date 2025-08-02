#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given three strings.
You are allowed to remove the rightmost character of a string to make all equals.
Write a script to return the number of operations to make it equal otherwise -1.
Example 1

Input: $s1 = "abc", $s2 = "abb", $s3 = "ab"
Output: 2

Operation 1: Delete "c" from the string "abc"
Operation 2: Delete "b" from the string "abb"

Example 2

Input: $s1 = "ayz", $s2 = "cyz", $s3 = "xyz"
Output: -1

Example 3

Input: $s1 = "yza", $s2 = "yzb", $s3 = "yzc"
Output: 3
=cut

use List::Util qw(uniq sum);
use utf8;
use Test2::V0 -no_srand => 1;

is(equal_strings("abc", "abb", "ab"), 2, 'Example 1');
is(equal_strings("ayz", "cyz", "xyz"), -1, 'Example 2');
is(equal_strings("yza", "yzb", "yzc"), 3, 'Example 3');
is(equal_strings("äöü", "äöß", "äöÜ"), 3, 'Example Unicode');
done_testing();

sub equal_strings
{
     my @strings = @_;
     @strings = sort { length($a) <=> length($b) } 
               map { utf8::upgrade($_); $_; } @strings; 
     my $common_length = 0;
     for my $idx ( 0 .. length($strings[0]) - 1 )
     {
          my @letters = map { substr($_, $idx, 1) } @strings;
          last if scalar uniq(@letters) > 1;
          $common_length++;
     }
     return -1 if $common_length == 0;
     my $steps = sum(map { length($_) - $common_length } @strings);
     return $steps;
}
