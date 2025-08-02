=begin
You are given an array of integers, @ints, whose length is a power of 2.

Write a script to play the order game (min and max) and return the last element.

Example 1
Input: @ints = (2, 1, 4, 5, 6, 3, 0, 2) #8 -> 2**3
Output: 1

Operation 1:

    min(2, 1) = 1
    max(4, 5) = 5
    min(6, 3) = 3
    max(0, 2) = 2

Operation 2:

    min(1, 5) = 1
    max(3, 2) = 3

Operation 3:

    min(1, 3) = 1
Example 2
Input: @ints = (0, 5, 3, 2)
Output: 0

Operation 1:

    min(0, 5) = 0
    max(3, 2) = 3

Operation 2:

    min(0, 3) = 0
Example 3
Input: @ints = (9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8)
Output: 2

Operation 1:

    min(9, 2) = 2
    max(1, 4) = 4
    min(5, 6) = 5
    max(0, 7) = 7
    min(3, 1) = 1
    max(3, 5) = 5
    min(7, 9) = 7
    max(0, 8) = 8

Operation 2:

    min(2, 4) = 2
    max(5, 7) = 7
    min(1, 5) = 1
    max(7, 8) = 8

Operation 3:

    min(2, 7) = 2
    max(1, 8) = 8

Operation 4:

    min(2, 8) = 2
=cut

use strict;
use warnings;
use List::Util qw(max);
use List::Util qw(min);

my @ints = ([2, 1, 4, 5, 6, 3, 0, 2],[0, 5, 3, 2],[9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8],[10],[200,2]);

foreach(@ints){
  my $a = $_;
  my $result = playGame(\@$a);
  print "$result \n";
}

sub playGame {
  my $arr = shift;
  my @A = @$arr;
  my $length = scalar @A;

  return $A[0] if $length == 1;
  return min($A[0],$A[1]) if $length == 2;

  my ($num1,$num2);
  my ($min,$max);
  my $op = 1;
  while(scalar $length > 1){
    my @res;
    for(my $i=0;$i<$length;$i+=2){
      if($op % 2 != 0){
        $num1 = $A[$i];
        $num2 = $A[$i+1]; 
        $max = min($num1,$num2);
        push @res,$max;
        $op += 1;
      }else{
        $num1 = $A[$i];
        $num2 = $A[$i+1]; 
        $min = max($num1,$num2);
        push @res,$min;
        $op += 1;
      }
    }
    $op = 1;
    @A = @res;
    $length = scalar @A;
  }
  return $A[0];
}