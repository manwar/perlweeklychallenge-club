#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string $S with 3 or more words. Write a script to find the length of the string except the first and last words ignoring whitespace.
Example 1: Input: $S = "The Weekly Challenge" Output: 6
Example 2: Input: $S = "The purpose of our lives is to be happy" Output: 23
=cut







use List::Util qw(reduce);
use Test::More;

sub words_length
{
     my $string = $_[0];
     my @words = split(/\s+/, $string);

     shift @words;

     pop @words;

     my $length = reduce {$a + $b} map length, @words;
     return $length;
}

is(words_length("The Weekly Challenge"), 6, 'Example 1');
is(words_length("The purpose of our lives is to be happy"), 23, 'Example 1');
done_testing();