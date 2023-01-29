#! /usr/bin/perl

# Robbie Hatley's Perl solution for Challenge 19-2.

=pod

Task 2: Range List 
Submitted by: Mohammad S Anwar 
Given a finite increasing sequence of unique integers, write a script 
to find all sub-sequences consisting of consecutive integers 
-- eg, (5, 6, 7) -- and represent each such sub-sequence as 
a closed interval [a,b]. For example, the sub-sequence (5, 6, 7) 
would be represented as the closed interval [5,7]. 

Example 1:  Input = (1,3,4,5,7)        Output: ([3,5]) 
Example 2:  Input = (1,2,3,6,7,9)      Output: ([1,3], [6,7]) 
Example 3:  Input = (0,1,2,4,5,6,8,9)  Output: ([0,2], [4,6], [8,9]) 

=cut

# NOTE: Input is via a built-in array of arrays, or command-line args. 
#       If using args, they should be a space-separated increasing 
#       sequence of unique integers, and will be iterpretted as being 
#       a single array. 

# NOTE: Output is to stdout and will be each input array followed by 
#       a list of all "ranges" found in the input array, expressed as 
#       closed intervals [a,b]. 

# PRELIMINARIES:
use v5.36;

# SUBROUTINES:
sub ranges(@array)
{
   my @ranges;
   for ( my $idx = 0 ; $idx < $#array ; ++$idx )
   {
      my $range = $idx + 1;
      for ( ; $range <= $#array ; ++$range )
      {
         last if $array[$range] != $array[$range - 1] + 1;
      }
      if ( $range > $idx + 1 )
      {
         push @ranges, [$array[$idx],$array[$range-1]];
         $idx = $range - 1;
      }
   }
   return @ranges;
}

# DEFAULT INPUT:
my @arrays = 
(
   [1,3,4,5,7],
   [1,2,3,6,7,9],
   [0,1,2,4,5,6,8,9]
);

# NON-DEFAULT INPUT:
if (@ARGV) {@arrays = ([@ARGV])}

# MAIN BODY OF SCRIPT:
for (@arrays)
{
   my @array = @{$_};
   my @ranges = ranges(@array);
   my @range_strings = map {sprintf("[%d,%d]",$_->[0],$_->[1])} @ranges;
   $"=', ';
   say '';
   say "Input array = (@array)";
   say "Ranges = @range_strings"
}
