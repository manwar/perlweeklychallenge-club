#! /usr/bin/perl

# ch-2.pl
# Robbie Hatley's Perl solution for Challenge 195-2

=pod

Task 2: Most Frequent Even
Submitted by: Mohammad S Anwar
Given a list of integers, write a script to find the most-frequent
even number in the list. If you get more than one even number with
the same frequency, return the smallest. If no even numbers are
present, return -1.

Example 1:  Input: (1,1,2,6,2)  Output: 2
Example 2:  Input: (1,3,5,7)    Output: -1
Example 3:  Input: (6,4,4,6,1)  Output: 4

=cut

# NOTE: Input is via built-in array of arrays, or command-line args.
#       If using args, they should be integers, and will be assumed
#       to be a single array.

# NOTE: Output is to stdout and will be each input number
#       $n followed by the count of all "special" integers
#       from 1 through $n.

# PRELIMINARIES:
use v5.36;

# DEFAULT INPUT:
my @arrays =
(
   [1,1,2,6,2],
   [1,3,5,7],
   [6,4,4,6,1]
);

# NON-DEFAULT INPUT:
if (@ARGV) {@arrays = ([@ARGV])}

# MAIN BODY OF SCRIPT:
for (@arrays)
{
   # Get array of numbers:
   my @array = @{$_};

   # Get hash of frequencies of even numbers:
   my %freq;
   for (@array) {++$freq{$_} unless $_ % 2}

   # Get array of even numbers, in decreasing order of frequency:
   my @evens = reverse sort {$freq{$a} <=> $freq{$b}} keys %freq;

   # Find minimum even with highest frequency (or -1 if no evens):
   my $min;
   if (!@evens)
   {
      $min = -1;
   }
   else
   {
      $min = $evens[0];
      for (@evens)
      {
         last if $freq{$_} < $freq{$evens[0]};
         $min = $_ if $_ < $min;
      }
   }

   # Display results:
   say '';
   say "array = @array";
   say "smallest most-frequent even = $min";
}
