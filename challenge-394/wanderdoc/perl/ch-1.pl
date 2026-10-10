#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string containing an equal number of uppercase and lowercase English letters.

Write a script to the minimum number of adjacent character swaps needed to turn the given string into an alternate case string.
Example 1

Input: $str = "aAbB"
Output: 0

Example 2

Input: $str = "AAbb"
Output: 1

Swap 1: "AbAb"

Example 3

Input: $str = "AAAbbb"
Output: 3

Swap 1: "AAbAbb"
Swap 2: "AbAAbb"
Swap 3: "AbAbAb"

Example 4

Input: $str = "aABb"
Output: 1

Swap 1: "aAbB"

Example 5

Input: $str = "bBBAaa"
Output: 2

Swap 1: "BbBAaa"
Swap 2: "BbBaAa"
=cut





use List::Util qw(min);
use Test2::V0 -no_srand => 1;
is(alternate_case("aAbB"), 0, 'Example 1');
is(alternate_case("AAbb"), 1, 'Example 2');
is(alternate_case("AAAbbb"), 3, 'Example 3');
is(alternate_case("aABb"), 1, 'Example 4');
is(alternate_case("bBBAaa"), 2, 'Example 5');
done_testing();

alternate_case("bBBAaa");

sub alternate_case
{
     my $str = $_[0];
     # my $upper_re = qr/[A-Z]/;
     # my $lower_re = qr/[a-z]/;
     
     my $str_copy = $str;
     my %swaps;
     while ( $str =~ s/(?<=[A-Z])([A-Z])([a-z])/$2$1/g )
     {
          $swaps{UPPER}++;
     }
     while ( $str_copy =~ s/([a-z])([A-Z])(?=[A-Z])/$2$1/g)
     {
          $swaps{LOWER}++;
     }
     return min(values %swaps) || 0;
}
