#! /usr/bin/perl

# ch-1.pl
# Robbie Hatley's Perl solution for Challenge 195-1

=pod

Task 1: Special Integers
Submitted by: Mohammad S Anwar
Given a positive integer $n, write a script to print the count
of all "special" integers from 1 through $n. (An integer is
"special" when all of its digits are unique.)
Example 1:  Input: 15  Output: 14
Example 2:  Input: 35  Output: 32

=cut

# NOTE: Input is via built-in array or command-line args.
#       If using args, they should be positive integers.

# NOTE: Output is to stdout and will be each input number
#       $n followed by the count of all "special" integers
#       from 1 through $n.

# PRELIMINARIES:
use v5.36;

# SUBROUTINES:

# Is a string "special" (has no repeated characters)?
sub is_special ($x)
{
   my $l = length($x); # number of characters
   for my $i (0..$l-2){
      for my $j ($i+1..$l-1){
         substr($x,$i,1) eq substr($x,$j,1) and return 0}}
   return 1;
}

# DEFAULT INPUT:
my @numbers = (15, 35);

# NON-DEFAULT INPUT:
if (@ARGV) {@numbers = @ARGV;}

# MAIN BODY OF SCRIPT:
for my $n (@numbers)
{
   my $count = 0; # count of "special" integers in (1..$n).
   for my $x (1..$n) {is_special($x) and ++$count}
   say "There are $count special integers from 1 through $n."
}
