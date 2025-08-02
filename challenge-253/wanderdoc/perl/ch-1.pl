#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of strings and a character separator.
Write a script to return all words separated by the given character excluding empty string.
Example 1

Input: @words = ("one.two.three","four.five","six")
       $separator = "."
Output: "one","two","three","four","five","six"

Example 2

Input: @words = ("$perl$$", "$$raku$")
       $separator = "$"
Output: "perl","raku"

=cut


use Test2::V0;


sub split_words
{
     my ($wds_aref, $sep) = @_;
     $sep = quotemeta $sep;
     my @output = 
          grep { length($_) > 0 }
          map { split(/$sep/, $_ ) } 
          @$wds_aref;
     return @output;
}

is(  join(" ", split_words([("one.two.three","four.five","six")], ".")),
     join(" ", ("one","two","three","four","five","six")) , 'Example 1' );
is(
     join(" ", split_words([('$perl$$', '$$raku$')], '$')),
     join(" ", ("perl", "raku")) , 'Example 2' );
done_testing();