#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string containing only lower case English letters and ?.
Write a script to replace all ? in the given string so that the string doesn't contain consecutive repeating characters.

Example 1

Input: $str = "a?z"
Output: "abz"

There can be many strings, one of them is "abz".
The choices are 'a' to 'z' but we can't use either 'a' or 'z' to replace the '?'.


Example 2

Input: $str = "pe?k"
Output: "peak"


Example 3

Input: $str = "gra?te"
Output: "grabte"
=cut

use Test2::V0 -no_srand => 1;

is(replace_question_marks("a?z"), "abz", "Example 1");
is(replace_question_marks("pe?k"), "peak", "Example 2");
is(replace_question_marks("gra?te"), "grabte", "Example 3");
is(replace_question_marks("gra?te?"), "grabtec", "Example 4");
is(replace_question_marks("a??z"), "abcz", "Example 5");
is(replace_question_marks("abc"), "abc", "Example 6");
done_testing();

sub replace_question_marks
{
     my $str = $_[0];
     for my $ltr ( 'a' .. 'z' )
     {
          my $copy = $str;
          $copy =~ s/(\?)/$ltr/;
          if ( $copy !~ /(?<char>.)\k<char>/)
          {
               $str = $copy;
          }
          if ($str !~ /\?/)
          {
               return $str;
          }
     }
}
