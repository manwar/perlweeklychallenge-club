#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string.
Write a script to find the length of last word in the given string.

Example 1

Input: $str = "The Weekly Challenge"
Output: 9


Example 2

Input: $str = "   Hello   World    "
Output: 5


Example 3

Input: $str = "Let's begin the fun"
Output: 3
=cut

use Test2::V0 -no_srand => 1;
is(last_word_length("The Weekly Challenge"), 9, "Example 1");
is(last_word_length("   Hello   World    "), 5, "Example 2");
is(last_word_length("Let's begin the fun"), 3, "Example 3");
done_testing();


sub last_word_length
{
     my $str = $_[0];
     return length((grep {length($_) > 0} 
               split(/\s/,$str))[-1]);
}
