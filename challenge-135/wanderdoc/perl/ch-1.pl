#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an integer. Write a script find out the middle 3-digits of the given integer, if possible otherwise throw sensible error.
=cut











sub middle_three
{
     my $num = $_[0];
     $num =~ tr/-//ds;
     return "Even number of digits!" if length($num) % 2 == 0;
     return "Too short!" if length($num) < 3;
     return $num if length($num) == 3;

     my $middle = length($num) / 2;
     return substr($num, int($middle) - 1, 3);
}


print middle_three(1234567), $/;
print middle_three(-123), $/;
print middle_three(1), $/;
print middle_three(10), $/;
print middle_three(1415926535897), $/;