#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of equal length strings.

Write a script to find the difference integer array of each word in the given array. There will be one word with a different array; return that word.

    Each words[i] can be converted into a difference integer array difference[i] of length n - 1 where difference[i][j] = words[i][j+1] - words[i][j]

Example 1

Input: @words = ("ab", "bc", "cd", "zy")
Output: "zy"

"ab" => [1 - 0] = [1]
"bc" => [2 - 1] = [1]
"cd" => [3 - 2] = [1]
"zy" => [24 - 25] = [-1]

Example 2

Input: @words = ("cba", "fed", "azy")
Output: "azy"

"cba" => [1 - 2, 0 - 1] = [-1, -1]
"fed" => [4 - 5, 3 - 4] = [-1, -1]
"azy" => [25 - 0, 24 - 25] = [25, -1]

Example 3

Input: @words = ("pop", "ada", "beb", "cfc")
Output: "pop"

"pop" => [14 - 15, 15 - 14] = [-1, 1]
"ada" => [3 - 0, 0 - 3] = [3, -3]
"beb" => [4 - 1, 1 - 4] = [3, -3]
"cfc" => [5 - 2, 2 - 5] = [3, -3]

Example 4

Input: @words = ("aaaa", "zzzz", "mmmm", "aaba")
Output: "aaba"

"aaaa" => [0 - 0, 0 - 0, 0 - 0] = [0, 0, 0]
"zzzz" => [25 - 25, 25 - 25, 25 - 25] = [0, 0, 0]
"mmmm" => [12 - 12, 12 - 12, 12 - 12] = [0, 0, 0]
"aaba" => [0 - 0, 1 - 0, 0 - 1] = [0, 1, -1]

Example 5

Input: @words = ("aceg", "bdfh", "cegi", "azbz")
Output: "azbz"

"aceg" => [2 - 0, 4 - 2, 6 - 4] = [2, 2, 2]
"bdfh" => [3 - 1, 5 - 3, 7 - 5] = [2, 2, 2]
"cegi" => [4 - 2, 6 - 4, 8 - 6] = [2, 2, 2]
"azbz" => [25 - 0, 1 - 25, 25 - 1] = [25, -24, 24]

=cut


use Test2::V0 -no_srand => 1;



is(string_difference("ab", "bc", "cd", "zy"), "zy", "Example 1");
is(string_difference("cba", "fed", "azy"), "azy", "Example 2");
is(string_difference("pop", "ada", "beb", "cfc"), "pop", "Example 3");
is(string_difference("aaaa", "zzzz", "mmmm", "aaba"), "aaba", "Example 4");
is(string_difference("aceg", "bdfh", "cegi", "azbz"), "azbz", "Example 5");
done_testing();

sub string_difference
{
     my @words = @_;
     my %letters;
     @letters{'a' .. 'z'} = 0 .. 25;
     my %num_string_to_word;
     my %counter;
     for my $word ( @words )
     {
          my @arr;

          for my $idx ( 0 .. length($word) - 2 )
          {
               my $num = $letters{ substr($word, $idx + 1, 1) } - 
                         $letters{ substr($word, $idx    , 1) };
               push @arr, $num;
          }
          my $num_string = join('~', @arr);
          $counter{$num_string}++;

          $num_string_to_word{$num_string} = $word;
     }
     my ($this_num_string) = grep { $counter{$_} == 1 } keys %counter;
     return $num_string_to_word{$this_num_string};
}
