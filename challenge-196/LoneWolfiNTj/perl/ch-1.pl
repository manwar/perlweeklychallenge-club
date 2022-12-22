#! /usr/bin/perl

# Robbie Hatley's Perl solution for Challenge 196-1.

=pod

Task 1: Pattern 132
Submitted by: Mohammad S Anwar
Given a list of integers, write a script to find all subsequences which 
exhibit Pattern 132 (ie, a sub-sequence, not necessarily contiguous, 
a[i], a[j], a[k] such that i < j < k and a[i] < a[k] < a[j]). 
If more than one such sub-sequence is found, return the first. 
If no such sub-sequence is found, return an empty array. 

Example 1:  Input = (3, 1, 4, 2)        Output = (1, 4, 2)
Example 2:  Input = (1, 2, 3, 4)        Output = ()
Example 3:  Input = (1, 3, 2, 4, 6, 5)  Output = (1, 3, 2) 
Example 4:  Input = (1, 3, 4, 2)        Output = (1, 3, 2)

=cut

# NOTE: Input is via built-in array of arrays, or command-line args.
#       If using args, they should be a space -separated sequence of 
#       integers, and will be interpreted as being a single array.

# NOTE: Output is to stdout and will be each input array followed by
#       a list of all sub-sequences exhibiting pattern 132, if any.

# PRELIMINARIES:
use v5.36;

# DEFAULT INPUT:
my @arrays = 
(
   [3, 1, 4, 2],
   [1, 2, 3, 4],
   [1, 3, 2, 4, 6, 5],
   [1, 3, 4, 2]
);

# NON-DEFAULT INPUT:
if (@ARGV) {@arrays = ([@ARGV])}

# SUBROUTINES:
sub p132 (@array) {
   my $size = scalar(@array);
   my @p132s;
   for (       my $i = 0      ; $i < $size - 2 ; ++$i ) {
      for (    my $j = $i + 1 ; $j < $size - 1 ; ++$j ) {
         for ( my $k = $j + 1 ; $k < $size - 0 ; ++$k ) {
            if ( $array[$i] < $array[$k] && $array[$k] < $array[$j] ) {
               push @p132s, [$array[$i], $array[$j], $array[$k]]}}}}
   return @p132s}

# MAIN BODY OF SCRIPT:
for (@arrays)
{
   my @array = @{$_};
   my @p132s = p132(@array);
   $"=', ';
   say '';
   say "Input array: (@{$_})";
   say "${\scalar(@p132s)} subsequences exhibit pattern 132";
   say "(@{$_})" for @p132s;
}
