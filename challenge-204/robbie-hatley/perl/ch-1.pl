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
my @arrays = ( [1,2,2,3], [1,3,2], [6,5,5,4], [42,42,42,42,42] );

# NON-DEFAULT INPUTS:
if (@ARGV) {@arrays = ([@ARGV]);}

# SUBROUTINES:

sub is_mono (@a){
   my $inc = 0;
   my $dec = 0;
   for ( my $i = 1 ; $i <= $#a ; ++$i ){
      if ($a[$i-1] < $a[$i]) {$inc = 1;}   # Increasing.
      if ($a[$i-1] > $a[$i]) {$dec = 1;}}  # Decreasing.
   return ($inc, $dec)}

# MAIN BODY OF SCRIPT:
for (@arrays){
   print "\n";
   my @array = @{$_};
   say "array: (@array)";
   my ($inc, $dec) = is_mono(@array);
   my $mono = 0+!($inc && $dec);
   print "$mono";
   if ($inc && !$dec){
      print " (monotonic and increasing)\n";}
   elsif (!$inc && $dec){
      print " (monotonic and decreasing)\n";}
   elsif (!$inc && !$dec){
      print " (monotonic and constant)\n"}
   else {
      print " (not monotonic)\n"}}