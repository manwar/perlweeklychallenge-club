#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string text of words that are placed among number of spaces.

Write a script to rearrange the spaces so that there is an equal number of spaces between every pair of adjacent words and that number is maximised. If you can't distribute, place the extra speaces at the end. Finally return the string.
Example 1

Input: $str = "  challenge  "
Output: "challenge    "

We have 4 spaces and 1 word. So all spaces go to the end.

Example 2

Input: $str = "coding  is  fun"
Output: "coding  is  fun"

We have 4 spaces and 3 words (2 gaps). So 2 spaces per gap.

Example 3

Input: $str = "a b c  d"
Output: "a b c d "

We have 4 spaces and 4 words (3 gaps). So 1 space per gap and 1 remainder.

Example 4

Input: $str = "  team      pwc  "
Output: "team          pwc"

We have 10 spaces and 2 words (1 gap). So 10 spaces per gap.

Example 5

Input: $str = "   the  weekly  challenge  "
Output: "the    weekly    challenge "

We have 9 spaces and 3 words (2 gaps). So 4 spaces per gap and 1 remainder.

=cut





use Test2::V0 -no_srand => 1;
is(reaarange_spaces("  challenge  "), "challenge    ", "Example 1");
is(reaarange_spaces("coding  is  fun"), "coding  is  fun", "Example 2");
is(reaarange_spaces("a b c  d"), "a b c d ", "Example 3");
is(reaarange_spaces("  team      pwc  "), "team          pwc", "Example 4");
is(reaarange_spaces("   the  weekly  challenge  "), "the    weekly    challenge ", "Example 5");
done_testing();



sub reaarange_spaces
{
     my $str = $_[0];
     my $num_of_spaces = $str =~ tr/ / /;
     my @words = grep length, split(/\s+/, $str);
     my $num_of_words = scalar(@words);
     if ( $num_of_words == 1 )
     {
          return $words[0] . ' ' x $num_of_spaces;
     }
     my $num_of_gaps = $num_of_words - 1;
     my $spaces_per_gap = int($num_of_spaces / $num_of_gaps);
     my $reminder = $num_of_spaces - $spaces_per_gap * $num_of_gaps;
     my $new_str = join(' ' x $spaces_per_gap, @words) .  ' ' x $reminder;
     return $new_str;
}
