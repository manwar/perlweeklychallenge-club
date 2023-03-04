#! /usr/bin/perl
# Robbie Hatley's Perl Solution to PWCC 206-2

=pod

Task 2: Array Pairings
Submitted by: Mohammad S Anwar
Given an array of integers having even number of elements, find the
maximum sum of the minimum of each pair.

Example 1:  Input: (1,2,3,4)  Output: 4
Pairings:
(1,2) and (3,4). So min(1,2) + min(3,4) => 1 + 3 => 4
(1,3) and (2,4). So min(1,3) + min(2,4) => 1 + 2 => 3
(1,4) and (2,3). So min(1,4) + min(2,3) => 2 + 1 => 3
So the maximum sum is 4.

Example 2:  Input: (0,2,1,3)  Output: 2
Pairings:
(0,2) and (1,3). So min(0,2) + min(1,3) => 0 + 1 => 1
(0,1) and (2,3). So min(0,1) + min(2,3) => 0 + 2 => 2
(0,3) and (2,1). So min(0,3) + min(2,1) => 0 + 1 => 1
So the maximum sum is 2.

=cut

# IO NOTES:
# NOTE: Input is by either built-in array-of-arrays, or @ARGV. If using @ARGV,
# the args should be a space-separated sequence of an even number of real numbers,
# which will be interpreted as being a single array.
# NOTE: Output is to STDOUT and will be the maximum sum of pair minimums.

# PRELIMINARIES:
use v5.36;
use List::Util 'sum0', 'max';
$"=", ";

# DEFAULT INPUTS:
my @arrays = ([1,2,3,4], [0,2,1,3]);

# NON-DEFAULT INPUTS:
if (@ARGV) {@arrays = ([@ARGV]);}

# SUBROUTINES:

sub MaxSumMinEasy($array=[]){
   return 0 if 0 == scalar @{$array};
   my @sorted = sort {$a<=>$b} @{$array};
   my $asize  = scalar(@sorted);
   die "Error in MaxSumMin(): array size not even.\n$!\n" if 0 != $asize % 2;
   my @even_indices; push @even_indices, 2*$_ for 0..($asize/2-1);
   return sum0(@sorted[@even_indices])}

sub Pairings ($array=[], $pairs=[]){
   state $recurse = 0;
   die "Error in Pairings(): Over 50 levels of recursion!\n$!\n" if $recurse > 50;
   state @pairings;
   # Clear @pairings on first entry, else @pairings accumulates garbage:
   @pairings = () if 0 == $recurse;
   my $asize = scalar(@{$array});
   die "Error in Pairings(): array size not even.\n$!\n" if 0 != $asize % 2;
   if (0 == $asize){
      push @pairings, $pairs;}
   else{
      for    ( my $i =    0   ; $i <= $asize - 2 ; ++$i ){
         for ( my $j = $i + 1 ; $j <= $asize - 1 ; ++$j ){
            my @recurse_array = @{$array};
            my @recurse_pairs = @{$pairs};
            my $p2 = splice @recurse_array, $j, 1; # $j MUST come first!!!
            my $p1 = splice @recurse_array, $i, 1; # Can you see why?
            push @recurse_pairs, [$p1, $p2];
            ++$recurse;
            Pairings(\@recurse_array, \@recurse_pairs);
            --$recurse}}}
   return \@pairings}

sub SumMin($pairing=[]){
   return sum0 map {(sort {$a<=>$b} @{$_})[0]} @{$pairing}}

sub MaxSumMinHard($pairings=[]){
   return max map {SumMin $_} @{$pairings};}

# MAIN BODY OF SCRIPT:
for (@arrays){
   my $array = $_;
   my $msme = MaxSumMinEasy($array);
   my $pairings = Pairings($array);
   my $numpai = scalar @{$pairings};
   my $msmh = MaxSumMinHard($pairings);
   say '';
   say "array: (@{$array})";
   say 'Pairings:';
   for (@{$pairings}){        # For each pairing
      for (@{$_}){            # For each pair
         print " [$_->[0],$_->[1]]";}
      print "  ", SumMin($_), "\n";}
   say "$numpai pairings";
   say "max-sum-min-easy = $msme";
   say "max-sum-min-hard = $msmh"}