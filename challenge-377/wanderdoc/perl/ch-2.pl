#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of strings.

Write a script to find if the two strings (str1, str2) in the given array such that str1 is prefix and suffix of str2. Return the total count of such pairs.
Example 1

Input: @array = ("a", "aba", "ababa", "aa")
Output: 4

$array[0], $array[1]: "a" is a prefix and suffix of "aba"
$array[0], $array[2]: "a" is a prefix and suffix of "ababa"
$array[0], $array[3]: "a" is a prefix and suffix of "aa"
$array[1], $array[2]: "aba" is a prefix and suffix of "ababa"

Example 2

Input: @array = ("pa", "papa", "ma", "mama")
Output: 2

$array[0], $array[1]: "pa" is a prefix and suffix of "papa"
$array[2], $array[3]: "ma" is a prefix and suffix of "mama"

Example 3

Input: @array = ("abao", "ab")
Output: 0

Example 4

Input: @array = ("abab", "abab")
Output: 1

$array[0], $array[1]: "abab" is a prefix and suffix of "abab"

Example 5

Input: @array = ("ab", "abab", "ababab")
Output: 3

$array[0], $array[1]: "ab" is a prefix and suffix of "abab"
$array[0], $array[2]: "ab" is a prefix and suffix of "ababab"
$array[1], $array[2]: "abab" is a prefix and suffix of "ababab"

Example 6

Input: @array = ("abc", "def", "ghij")
Output: 0

=cut





use Test2::V0 -no_srand => 1;

is(prefix_suffix("a", "aba", "ababa", "aa"), 4, 'Example 1');
is(prefix_suffix("pa", "papa", "ma", "mama"), 2, 'Example 2');
is(prefix_suffix("abao", "ab"), 0, 'Example 3');
is(prefix_suffix("abab", "abab"), 1, 'Example 4');
is(prefix_suffix("ab", "abab", "ababab"), 3, 'Example 5');
is(prefix_suffix("abc", "def", "ghij"), 0, 'Example 6');

done_testing();


sub prefix_suffix
{
     my @arr = @_;
     my $counter = 0;
     for my $i ( 0 .. $#arr - 1 )
     {
          for my $j ( $i + 1 .. $#arr )
          {
               my $first = $arr[$i];
               my $second = $arr[$j]; 
               if ( $second =~ /^$first/ and $second =~ /$first$/ )
               {
                    $counter++;
               }
          }
     }
     return $counter;
}
