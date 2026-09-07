#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a string representing a number, and an integer specifying the base of that representation.

Write a function to convert this string to an integer. (For bases greater than 10, use characters A-Z, a-z, + and / in that order.)
Example 1

Input: $num = "101010", $base = 2
Output: 42

Example 2

Input: $num = "EEADEE", $base = 16
Output: 15642094

Example 3

Input: $num = "755", $base = 8
Output: 493

Example 4

Input: $num = "1BRJB", $base = 36
Output: 2228519

Example 5

Input: $num = "7MyqL", $base = 64
Output: 123456789

=cut





use Test2::V0 -no_srand => 1;
is(base_N_to_int("101010", 2), 42, 'Example 1');
is(base_N_to_int("EEADEE", 16), 15642094, 'Example 2');
is(base_N_to_int("755", 8), 493, 'Example 3');
is(base_N_to_int("1BRJB", 36), 2228519, 'Example 4');
is(base_N_to_int("7MyqL", 64), 123456789, 'Example 5');
done_testing();


sub base_N_to_int
{
     my ($str, $base) = @_;
     my $num;
     if ( $base == 10 )
     {
          $num = $str;
     }
     elsif ( $base == 16 )
     {
          $num = hex("0x$str");
     }
     elsif ( $base == 8 )
     {
          $num = oct("0$str");
     }
     elsif ( $base == 2 )
     {
          $num = oct("0b$str");
     }
     else
     {
          my @chars = ('0'..'9', 'A'..'Z', 'a' .. 'z', '+', '/');
          my $counter = 0;
          my %dict = map { $_ => $counter++ } @chars;
          $num = 0;
          for my $chr ( split(//, $str) )
          {
               my $digit = $dict{$chr};
               if ( not defined $digit or $digit >= $base )
               {
                    die "Invalid input: $str";
               }
               $num = $num * $base + $digit;
          }
     }
     return $num;
}
