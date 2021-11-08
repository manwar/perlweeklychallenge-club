#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a positive integer $N.
Write a script to find out if the binary representation of the given integer is Palindrome. Print 1 if it is otherwise 0.
Example Input: $N = 5
Output: 1 as binary representation of 5 is 101 which is Palindrome.
Input: $N = 4
Output: 0 as binary representation of 4 is 100 which is NOT Palindrome.
=cut





sub dec_to_bin { return sprintf("%b",$_[0]); }
sub is_palindrome { return $_[0] eq reverse($_[0]) ? 1 : 0 ; }

for my $num ( 1 .. 255)
{
     print join("\t", $num, dec_to_bin($num), is_palindrome(dec_to_bin($num))), $/;
}