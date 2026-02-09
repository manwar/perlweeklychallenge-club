#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a word containing only alphabets,

Write a function that repeatedly removes adjacent duplicate characters from a string until no adjacent duplicates remain and return the final word.
Example 1

Input: $word = "aabbccdd"
Output: ""

Iteration 1: remove "aa", "bb", "cc", "dd" => ""


Example 2

Input: $word = "abccba"
Output: ""

Iteration 1: remove "cc" => "abba"
Iteration 2: remove "bb" => "aa"
Iteration 3: remove "aa" => ""


Example 3

Input: $word = "abcdef"
Output: "abcdef"

No duplicate found.



Example 4
Input: $word = "aabbaeaccdd"
Output: "aea"


Iteration 1: remove "aa", "bb", "cc", "dd" => "aea"

Example 5
Input: $word = "mississippi"
Output: "m"

Iteration 1: Remove "ss", "ss", "pp" => "miiii"
Iteration 2: Remove "ii", "ii" => "m"

=cut

use Test2::V0 -no_srand => 1;
is(string_reduction("aabbccdd"), '', 'Example 1');
is(string_reduction("abccba"), '', 'Example 2');
is(string_reduction("abcdef"), 'abcdef', 'Example 3');
is(string_reduction("aabbaeaccdd"), 'aea', 'Example 4');
is(string_reduction("mississippi"), 'm', 'Example 5');
done_testing();


sub string_reduction
{
     my $str = $_[0];
     while ( $str =~ /(?<char>.)\k<char>/ )
     {
          $str =~ s/(?<char>.)\k<char>//g;
     }
     return $str;
}
