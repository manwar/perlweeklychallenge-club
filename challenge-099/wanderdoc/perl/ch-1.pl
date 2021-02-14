#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string $S and a pattern $P.
Write a script to check if given pattern validate the entire string. Print 1 if pass otherwise 0.
The patterns can also have the following characters: ? - Match any single character. * - Match any sequence of characters.
Example 1: Input: $S = "abcde" $P = "a*e"   Output: 1
Example 2: Input: $S = "abcde" $P = "a*d"   Output: 0
Example 3: Input: $S = "abcde" $P = "?b*d"  Output: 0
Example 4: Input: $S = "abcde" $P = "a*c?e" Output: 1

=cut




use Test::More;

sub pattern_match
{
     my ($string, $pattern) = @_;

     my $re = my_glob2regex_string($pattern); # or better use Text::Globe

     $re = qr/\A$re\z/;
     return $string =~ $re ? 1 : 0;
}

sub my_glob2regex_string
{
     my $pattern = $_[0];
     $pattern =~ s/\*/.*/g; 
     $pattern =~ s/\?/./g;
     return $pattern;
}



is(pattern_match(qw(abcde a*e)),   1, 'Example 1');
is(pattern_match(qw(abcde a*d)),   0, 'Example 2');
is(pattern_match(qw(abcde ?b*d)),  0, 'Example 3');

is(pattern_match(qw(abcde a*c?e)), 1, 'Example 4');
is(pattern_match(qw(abcde *e*)),   1, 'Example 5');
done_testing();