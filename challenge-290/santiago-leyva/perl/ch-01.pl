=begin
You are given an array of integers, @ints.

Write a script to find if there exist two indices $i and $j such that:

1) $i != $j
2) 0 <= ($i, $j) < scalar @ints
3) $ints[$i] == 2 * $ints[$j]

Example 1
Input: @ints = (6, 2, 3, 3)
Output: true

For $i = 0, $j = 2
$ints[$i] = 6 => 2 * 3 =>  2 * $ints[$j]

Example 2
Input: @ints = (3, 1, 4, 13)
Output: false

Example 3
Input: @ints = (2, 1, 4, 2)
Output: true

For $i = 2, $j = 3
$ints[$i] = 4 => 2 * 2 =>  2 * $ints[$j]
=cut

use strict;
use warnings;
use Data::Dumper;
use Test::More tests=>3;
my @ints = ([6, 2, 3, 3],[3, 1, 4, 13],[2, 1, 4, 2],[10,10,5,2,5,1]);

# foreach(@ints){
#   my @arr = @$_;
#   my $result = checkIndices(\@arr);
#   print "$result \n"; 
# }

sub checkIndices {
  my $arr = shift;
  my @A = @$arr;
  my $n = scalar @A;

  my %set;

  for(my $i=0;$i<$n;$i++){
    if(exists( $set{$A[$i]} )){
      push( @{$set{$A[$i]}}, $i);
    }else{
      $set{$A[$i]} = [$i];
    }
  }

  for(my $j=0;$j<$n;$j++){

    my $desired = 2 * $A[$j];
    if(exists($set{$desired})){
      my @ind = @{$set{$desired}};
      foreach my $i (@ind){
        if($i != $j and $j > $i){
          return "true";
        }
      }
    }
  }
  return "false";
}

my @example1 = (6, 2, 3, 3);
my @example2 = (3, 1, 4, 13);
my @example3 = (2, 1, 4, 2);

is(checkIndices(\@example1),"true");
is(checkIndices(\@example2),"false");
is(checkIndices(\@example3),"true");