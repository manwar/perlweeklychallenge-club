=begin

You are given two arrays, @letters and @weights.

Write a script to sort the given array @letters based on the @weights.

Example 1
Input: @letters = ('R', 'E', 'P', 'L')
       @weights = (3, 2, 1, 4)
Output: PERL
Example 2
Input: @letters = ('A', 'U', 'R', 'K')
       @weights = (2, 4, 1, 3)
Output: RAKU
Example 3
Input: @letters = ('O', 'H', 'Y', 'N', 'P', 'T')
       @weights = (5, 4, 2, 6, 1, 3)
Output: PYTHON

=cut

use strict;
use Data::Dumper;

my @letters = (['R', 'E', 'P', 'L'],['A', 'U', 'R', 'K'],['O', 'H', 'Y', 'N', 'P', 'T']);
my @weights = ([3, 2, 1, 4],[2, 4, 1, 3],[5, 4, 2, 6, 1, 3]);

for(0..(scalar @weights)-1){
  sortArray($letters[$_],$weights[$_]);
}

sub sortArray {
  my $let = shift;
  my $wgt = shift;
  my @letters_ = @$let;
  my @weights_ = @$wgt;
  my %map;
  my $n = scalar(@weights_);
  foreach my $i (0..$n){
    $map{$weights_[$i]} = $letters_[$i];
  }
  foreach(sort(keys %map)){ 
      print $map{$_};
  }
  print "\n"; 
}