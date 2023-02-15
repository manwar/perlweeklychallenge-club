#! /usr/bin/perl
# Robbie Hatley's Solution to PWCC 204-1

=pod

Task 1: Monotonic Array
Submitted by: Mohammad S Anwar
Given an array of integers, write a script that prints 1 if the given array
is Monotonic, else prints 0.
Example 1:  Input: (1,2,2,3)  Output: 1
Example 2:  Input: (1,3,2)    Output: 0
Example 3:  Input: (6,5,5,4)  Output: 1

=cut

# IO NOTES:
# NOTE: Input is by either built-in array-of-arrays, or @ARGV.
#       If using @ARGV,the args should be a space-separated sequence of
#       integers, which will be interpreted as being a single array.
# NOTE: Output is to STDOUT and will be 1 if monotonic, 0 if not.

# PRELIMINARIES:
use v5.36;
$"=", ";

# DEFAULT INPUTS:
my @arrays = ( [1,2,2,3], [1,3,2], [6,5,5,4] );

# NON-DEFAULT INPUTS:
if (@ARGV) {@arrays = ([@ARGV]);}

# SUBROUTINES:

sub is_mono (@a){
   my $mono;
   $mono = 1;
   for ( my $i = 1 ; $i <= $#a ; ++$i ){
      $mono &&= ($a[$i-1]<=$a[$i]);} # mono inc?
   if ( $mono == 1 ) {return 1;}
   $mono = 1;
   for ( my $i = 1 ; $i <= $#a ; ++$i ){
      $mono &&= ($a[$i-1]>=$a[$i]);} # mono dec?
   if ( $mono == 1 ) {return 2;}
   return 0;}

# MAIN BODY OF SCRIPT:
for (@arrays){
   my @array = @{$_};
   say '';
   say "array: (@array)";
   my $mono = is_mono(@array);
   if ($mono == 0){
      say "not monotonic"}
   elsif ($mono == 1){
      say "monotonically increasing"}
   elsif ($mono == 2){
      say "monotonically decreasing"}
   else {
      say "We never had to take any of it seriously, did we?"}}