#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a list of words containing alphabetic characters only.
Write a script to return the count of words either starting with a vowel or ending with a vowel.

Example 1

Input: @list = ("unicode", "xml", "raku", "perl")
Output: 2

The words are "unicode" and "raku".


Example 2

Input: @list = ("the", "weekly", "challenge")
Output: 2


Example 3

Input: @list = ("perl", "python", "postgres")
Output: 0
=cut

use Test2::V0 -no_srand => 1;
is(count_words("unicode", "xml", "raku", "perl"), 2, 'Example 1');
is(count_words("the", "weekly", "challenge"), 2, 'Example 2');
is(count_words("perl", "python", "postgres"), 0, 'Example 3');
done_testing();



sub count_words
{
     my @words = @_;
     my $vowels = qr/[aeiou]/;
     my $counter = 0;
     for my $word ( @words )
     {
          if ( substr($word, 0, 1) =~ $vowels or 
               substr($word, -1, 1) =~ $vowels )
          {
               $counter++;
          }
     }
     return $counter;
}
