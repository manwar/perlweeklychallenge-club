#! /usr/bin/perl

# ======= DOCUMENTATION =======

=pod

Task 1: Binary String
Submitted by: Mohammad S Anwar

You are given an integer, $n > 0. Write a script to find all
possible binary numbers of size $n.

Example 1
Input: $n = 2
Output: 00, 11, 01, 10

Example 2
Input: $n = 3
Output: 000, 001, 010, 100, 111, 110, 101, 011

=cut

# Note: input is via an internal array of positive integers,
# or by arguments consisting of a space-separated sequence of
# positive integers.

# Note: output is to stdout and will be each input number n
# followed by all possible n-digit binary numbers (assuming
# that all digits are "significant" including leading zeros).

# ======= PRELIMINARIES =======

use v5.36;

# Set output field separator to ", " for printing:
$,=', ';

# ======= SUBROUTINES =======

# (didn't need any)

# ======= MAIN BODY OF SCRIPT =======

# Default input:
my @lengths = (1,2,3,4);

# Non-default input:
if (scalar(@ARGV)>0)
{
   @lengths = ();
   for (@ARGV)
   {
      push @lengths, abs(0+$_);
   }
}

# Create and print output:
for my $length (@lengths)
{
   my @numbers;
   for my $number (0..2**$length-1)
   {
      push @numbers, sprintf("%0${length}b", $number);
   }
   say "\nAll binary numbers of length $length:";
   say @numbers;
}

exit;

__END__
