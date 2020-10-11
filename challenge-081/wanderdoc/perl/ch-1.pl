#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given 2 strings, $A and $B. Write a script to find out common base string in $A and $B.
A substring of a string $S is called base string if repeated concatenation of the substring results in the string.

Example 1:
Input: $A = "abcdabcd" $B = "abcdabcdabcdabcd" Output: ("abcd", "abcdabcd")
Example 2: Input: $A = "aaa" $B = "aa" Output: ("a")
=cut




sub common_base
{
     my ($long, $short) = @_;
     if ( length($long) < length($short) )
     {
          ($long, $short) = ($short, $long);
     }
     my @output;
     my $len_short = length($short);

     my $len_long = length($long);
     for my $i ( reverse 1 .. $len_short )
     {
          my $fraction = $len_long / ($len_short - $i + 1);
          next unless $fraction == int($fraction);
          my $candidate = substr($short, $i - 1);
          if ( $long eq $candidate x  $fraction )
          {
               push @output, $candidate;
          }
     }
     return @output;


}
print "> ", join(' ', common_base('abcdabcd', 'abcdabcdabcdabcd')), $/;
print "> ", join(' ', common_base('aa', 'aaa')), $/;
print "> ", join(' ', common_base('abcdabcdabcdabcdabcdabcd', 'abcdabcdabcd')), $/;