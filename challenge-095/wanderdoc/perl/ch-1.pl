#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a number $N. Write a script to figure out if the given number is Palindrome. Print 1 if true otherwise 0.
Example 1: Input: 1221 Output: 1
Example 2: Input: -101 Output: 0, since -101 and 101- are not the same.
Example 3: Input: 90 Output: 0
=cut






use Regexp::Common;
use Test::More;

sub is_palindrom_number
{
     my $num = $_[0];
     die "Not a number!$/" unless $num =~ $RE{num}{real};

     my $rev = reverse $num;

     return ($num eq $rev ) ? 1 : 0;
}

is(is_palindrom_number(1221), 1, 'Example 1');
is(is_palindrom_number(-101), 0, 'Example 2');
is(is_palindrom_number(90),   0, 'Example 3');

done_testing();