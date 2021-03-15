#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string $S. Write a script to reverse the order of words in the given string. The string may contain leading/trailing spaces. The string may have more than one space between words in the string. Print the result without leading/trailing spaces and there should be only one space between words.
Example 1: Input: $S = "The Weekly Challenge" Output: "Challenge Weekly The"
Example 2: Input: $S = "    Perl and   Raku are  part of the same family  "
Output: "family same the of part are Raku and Perl"
=cut






use Test::More;

sub reverse_words
{
     my $str = $_[0];
     my @words = grep length($_), split(/\s+/, $str);
     return join(' ', reverse @words);

}

is(reverse_words('The Weekly Challenge'), 'Challenge Weekly The', 'Example 1');
is(reverse_words('    Perl and   Raku are  part of the same family  '),
     'family same the of part are Raku and Perl', 'Example 2');


done_testing();