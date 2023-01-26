#! /usr/bin/perl
# Robbie Hatley's Perl solution to PWCC 201-1

=pod

Task 1: Missing Numbers
Submitted by: Mohammad S Anwar

Given an array of unique integers, write a script to find out all missing 
integers in the range 0..$n where $n is the array size.

Example 1:  Input = (0,1,3)  Output = 2
The array size i.e. total element count is 3, so the range is 0..3.
The missing number is 2 in the given array.

Example 2:  Input = (0,1)  Output = 2
The array size is 2, therefore the range is 0..2.
The missing number is 2.

=cut

# IO NOTES:
#
# NOTE: Input is from @ARGV and must be a space-separated list of
#       1-or-more integers.
#
# NOTE: Output will be to stdout and will be the both the "missing"
#       integers in the range 0..$size and the "missing" integers
#       in the range $min..$max.

# PRELIMINARIES:
use v5.36;
$,=" ";

# SUBROUTINES:

# Does a scalar look like an integer?
sub looks_like_integer($x){
   return $x =~ m/(?:^0$)|(?:^-?[1-9]\d*$)/}

# Print message and die if program encounters an error:
sub croak{
   die "Error: This program must have one-or-more arguments,\n".
       "which must be integers.\n"}

sub is_in ($aref, $x) {
   for (@{$aref}) {return 1 if $x == $_}
   return 0;}

# INPUT:

# Die unless we have 1-or-more arguments:
croak if scalar(@ARGV) < 1;

# Die unless all arguments are integers:
map {croak if !looks_like_integer($_)} @ARGV;

# MAIN BODY OF SCRIPT:
my $size = scalar @ARGV;
my @missing_zer_siz = ();
my @missing_min_max = ();
my $min = $ARGV[0]; for (@ARGV) {$min = $_ if $_<$min}
my $max = $ARGV[0]; for (@ARGV) {$max = $_ if $_>$max}
for (0..$size){
   push @missing_zer_siz, $_ if !is_in(\@ARGV, $_)}
for ($min..$max){
   push @missing_min_max, $_ if !is_in(\@ARGV, $_)}
say "missing integers in zero-to-size range:";
say "(@missing_zer_siz)";
say "missing integers in min-to-max range:";
say "(@missing_min_max)";
