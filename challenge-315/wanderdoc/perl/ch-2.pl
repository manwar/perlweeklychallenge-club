#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a sentence and two words.

Write a script to return all words in the given sentence that appear in sequence to the given two words.
Example 1

Input: $sentence = "Perl is a my favourite language but Python is my favourite too."
       $first = "my"
       $second = "favourite"
Output: ("language", "too")

Example 2

Input: $sentence = "Barbie is a beautiful doll also also a beautiful princess."
       $first = "a"
       $second = "beautiful"
Output: ("doll", "princess")

Example 3

Input: $sentence = "we will we will rock you rock you.",
       $first = "we"
       $second = "will"
Output: ("we", "rock")
=cut

use utf8;
use Test2::V0 -no_srand => 1;
is(find_third("Perl is a my favourite language but Python is my favourite too.", "my", "favourite"), ["language", "too"], 'Example 1');
is(find_third("Barbie is a beautiful doll also also a beautiful princess.", "a", "beautiful"), ["doll", "princess"], 'Example 2');
is(find_third("we will we will rock you rock you.", "we", "will"), ["we", "rock"], 'Example 3');

done_testing();

sub find_third
{
     my ($sentence, $first, $second) = 
          map { utf8::upgrade($_); $_ } @_;
     $sentence = join(' ', split(/\s+/, $sentence)); # probably useful.
     my $chain = join(' ', $first, $second);
     my $re = qr/$chain/;
     my @output = $sentence =~ /(?<=$re) (\p{L}+)/g;
     return [@output];
}
