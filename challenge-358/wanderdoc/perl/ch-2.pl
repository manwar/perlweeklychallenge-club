#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string $str and an integer $int.

Write a script to encrypt the string using the algorithm - for each character $char in $str, replace $char with the $int th character after $char in the alphabet, wrapping if needed and return the encrypted string.
Example 1

Input: $str = "abc", $int = 1
Output: "bcd"


Example 2

Input: $str = "xyz", $int = 2
Output: "zab"


Example 3

Input: $str = "abc", $int = 27
Output: "bcd"


Example 4

Input: $str = "hello", $int = 5
Output: "mjqqt"


Example 5

Input: $str = "perl", $int = 26
Output: "perl"

=cut


use Test2::V0 -no_srand => 1;
is(encrypted("abc", 1), "bcd", "Example 1");
is(encrypted("xyz", 2), "zab", "Example 2");
is(encrypted("abc", 27), "bcd", "Example 3");
is(encrypted("hello", 5), "mjqqt", "Example 4");
is(encrypted("perl", 26), "perl", "Example 5");
done_testing();


sub encrypted
{
     my $str = $_[0];
     my $int = $_[1];
     my %alphabet;
     @alphabet{'a' .. 'z'} = 1 .. 26;
     my %numbers = reverse %alphabet;
     my @output;
     for my $letter ( split(//, $str) )
     {
          push @output, 
               $numbers{ ($alphabet{$letter} + $int) % 26 || 26 };
     }
     return join('', @output);
}
