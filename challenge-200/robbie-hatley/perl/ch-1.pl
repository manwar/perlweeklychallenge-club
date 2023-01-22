#! /usr/bin/perl
# Robbie Hatley's Perl solution to The Weekly Challenge #200-1

=pod

Task 1: Arithmetic Slices
Submitted by: Mohammad S Anwar
You are given an array of integers. Write a script to find out all Arithmetic
Slices for the given array of integers. An integer array is called "arithmetic"
if it has at least 3 elements and the differences between any three
consecutive elements are the same.

Example 1:  Input: @array = (1,2,3,4)  Output: (1,2,3), (2,3,4), (1,2,3,4)
Example 2:  Input: @array = (2)        Output: () as no slice found.

=cut

# IO NOTES:
#
# NOTE: Input is by either built-in array of arrays, or by @ARGV. If using
#       @ARGV, input should be a space-separated list of integers, which will
#       be interpreted as a single array.
#
# NOTE: Output is to stdout and will be a list of all arithmetic slice for
#       each input array.

# PRELIMINARIES:
use v5.36;
$,=" ";

# SUBROUTINES:

sub is_arith($slice_ref){
   my @slice = @{$slice_ref};
   my $size = scalar @slice;
   if ( $size < 3 ) {return 0;}
   my $init = $slice[1]-$slice[0];
   for ( my $idx = 2 ; $idx <= $#slice ; ++$idx ){
      if ($slice[$idx] - $slice[$idx-1] != $init) {return 0}}
   return 1;}

sub get_arith_slices($array_ref){
   my @array = @{$array_ref};
   my @slices = ();
   my @arith_slices = ();
   my $size = scalar @array;
   my @masks = (0..((2**$size)-1));
   foreach my $mask (@masks){
      my @slice = ();
      for ( my $idx = 0 ; $idx <= $#array ; ++$idx ){
         my $yesno = ($mask/2**($size-$idx-1))%2;
         if ($yesno) {push @slice, $array[$idx]}}
      push @slices, \@slice;}
   foreach my $slice_ref (@slices){
      if (is_arith($slice_ref)) {push @arith_slices, $slice_ref}}
   return @arith_slices;}

# DEFAULT INPUT:
my @arrays = ([1,2,3,4],[2]);

# NON-DEFAULT INPUT:
if (@ARGV) {@arrays = ([@ARGV])}

# MAIN BODY OF SCRIPT:
for (@arrays){
   my $array_ref = $_;
   my @array = @{$array_ref};
   my @arith_slices = get_arith_slices($array_ref);
   my $num_arith_slices = scalar @arith_slices;
   say '';
   say "Array = (@array)";
   say "Found $num_arith_slices arithmetic slices:";
   for (@arith_slices) {my @slice=@{$_}; say "(@slice)";}}