#! /usr/bin/perl

# PWCC_189_P2_Array-Degree_Robbie-Hatley.pl

=pod

Task 2: Array Degree
Submitted by: Mohammad S Anwar

You are given an array of 2 or more non-negative integers.

Write a script to find out the smallest slice, i.e. contiguous subarray of the original array, having the degree of the given array.

    The degree of an array is the maximum frequency of an element in the array.

Example 1

Input: @array = (1, 3, 3, 2)
Output: (3, 3)

The degree of the given array is 2.
The possible subarrays having the degree 2 are as below:
(3, 3)
(1, 3, 3)
(3, 3, 2)
(1, 3, 3, 2)

And the smallest of all is (3, 3).

Example 2

Input: @array = (1, 2, 1, 3)
Output: (1, 2, 1)

Example 3

Input: @array = (1, 3, 2, 1, 2)
Output: (2, 1, 2)

Example 4

Input: @array = (1, 1, 2, 3, 2)
Output: (1, 1)

Example 5

Input: @array = (2, 1, 2, 1, 1)
Output: (1, 2, 1, 1)


=cut

# NOTE: Input is via command-line arguments, which should be a
#       space-separated list of zero-or-more items of any kind.

# NOTE: Output is to stdout, and will be the smallest slice of
#       the input list having the degree of the original list.

use v5.36;

# Given an array of 0-or-more items, what is its degree?
sub degree (@array)
{
   my $degree = 0;
   my %hash;
   for (@array) {++$hash{$_};} # autovivify hash
   for (keys %hash) {$degree = $hash{$_} if $hash{$_} > $degree;}
   return $degree;
}

# What is the degree of @ARGV?
my $degree = degree(@ARGV);

# Biggest slice with degree of entire array is entire array:
my @smallest_slice = @ARGV;

# Are there smaller slices with same degree?
my @slice;
for ( my $i = 0 ; $i <= $#ARGV ; ++$i )
{
   for ( my $j = $i ; $j <= $#ARGV ; ++$j )
   {
      @slice = @ARGV[$i..$j];
      degree(@slice) == $degree
      && scalar(@slice) < scalar(@smallest_slice)
      and @smallest_slice = @slice;
   }
}

# Print smallest slice and exit:
$, = ', '; print '('; print @smallest_slice; print ")\n";
exit;
__END__
