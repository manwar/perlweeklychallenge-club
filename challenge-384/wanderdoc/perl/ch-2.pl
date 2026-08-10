#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a binary string.

Write a script to return all non-empty substrings (distinct) that have the same number of 0’s and 1’s, and all the 0’s and all the 1’s in these substrings are grouped consecutively.
Example 1

Input: $binary = "0101"
Output: ("01", "10")

Example 2

Input: $binary = "000111"
Output: ("000111", "0011", "01")

Example 3

Input: $binary = "000011"
Output:  ("0011", "01")

Example 4

Input: $binary = "10011100"
Output: ("10", "0011", "01", "1100")

Example 5

Input: $binary = "00000"
Output: ()
=cut

print join(" ", binary_substrings("0101")), $/; # 10 01
print join(" ", binary_substrings("000111")), $/; # 000111 01 0011
print join(" ", binary_substrings("000011")), $/; # 01 0011
print join(" ", binary_substrings("10011100")), $/; # 1100 0011 10 01
print join(" ", binary_substrings("00000")), $/; # empty



sub binary_substrings
{
     my $string = $_[0];
     my %output;
     # my $counter = 0;
     while ($string =~ /(0+1+|1+0+)/g)
     {
          my $substr = $1;

          pos($string) -= (length($substr) - 1);
          my $num_0 = $substr =~ tr/0/0/;
          my $num_1 = $substr =~ tr/1/1/;
          
          if ( $num_0 != $num_1 )
          {
               my $min = $num_0 < $num_1 ? $num_0 : $num_1;
               $substr = (substr($substr,  0, 1) x $min) . 
                         (substr($substr, -1, 1) x $min);
          }
          
          $output{$substr} = undef; # $counter++
     }
     return 
          # sort { $output{$a} <=> $output{$b} } 
          keys %output;
}

