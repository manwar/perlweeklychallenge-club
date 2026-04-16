#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string, group size and filler character.

Write a script to divide the string into groups of given size. In the last group if the string doesn't have enough characters remaining fill with the given filler character.
Example 1

Input: $str = "RakuPerl", $size = 4, $filler = "*"
Output: ("Raku", "Perl")

Example 2

Input: $str = "Python", $size = 5, $filler = "0"
Output: ("Pytho", "n0000")

Example 3

Input: $str = "12345", $size = 3, $filler = "x"
Output: ("123", "45x")

Example 4

Input: $str = "HelloWorld", $size = 3, $filler = "_"
Output: ("Hel", "loW", "orl", "d__")

Example 5

Input: $str = "AI", $size = 5, $filler = "!"
Output: "AI!!!"

=cut






use Test2::V0 -no_srand => 1;

is([make_groups("RakuPerl", 4, "*")], [("Raku", "Perl")], "Example 1");
is([make_groups("Python", 5, "0")], [("Pytho", "n0000")], "Example 2");
is([make_groups("12345", 3, "x")], [("123", "45x")], "Example 3");
is([make_groups("HelloWorld", 3, "_")], [("Hel", "loW", "orl", "d__")], "Example 4");
is(make_groups("AI", 5, "!"), "AI!!!", "Example 5");
done_testing();

sub make_groups
{
     my ($str, $size, $filler) = @_;
     my $pattern = "a${size}";
     my @arr = unpack "($pattern)*", $str;
     @arr = map { my $l = length($_); 
                  $l < $size ? $_ . $filler x ($size - $l) : $_ } 
                  @arr;
     return scalar @arr > 1 ? @arr : $arr[0];
     
}
