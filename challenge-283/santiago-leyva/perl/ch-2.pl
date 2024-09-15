=begin
You are given an array of positive integers, @ints.

Write a script to return true if for every index i in the range 0 <= i < size of array, the digit i occurs exactly the $ints[$i] times in the given array otherwise return false.

Example 1
Input: @ints = (1, 2, 1, 0)
Ouput: true

$ints[0] = 1, the digit 0 occurs exactly 1 time.
$ints[1] = 2, the digit 1 occurs exactly 2 times.
$ints[2] = 1, the digit 2 occurs exactly 1 time.
$ints[3] = 0, the digit 3 occurs 0 time.
Example 2
Input: @ints = (0, 3, 0)
Ouput: false

$ints[0] = 0, the digit 0 occurs 2 times rather than 0 time.
$ints[1] = 3, the digit 1 occurs 0 time rather than 3 times.
$ints[2] = 0, the digit 2 occurs exactly 0 time.
=cut
use strict;
use Data::Dumper;


my @inputs = ([1, 2, 1, 0],[0, 3, 0]);

foreach(@inputs){
  my $arr = $_;
  my @A = @$arr;
  my $result = checkIndex(\@A);
  print $result."\n";
}

sub checkIndex {
  my $array = shift;
  my @nums = @$array;

  my %seen;
  my %deleted;
  foreach(@nums){

    if(exists($seen{$_})){
      $seen{$_} += 1;
    }else{
        $seen{$_} = 1;
      }
  }

  my $i = 0;
  foreach(@nums){
    if(!exists($seen{$i}) and $seen{$i} != $_){
      return 'false';
    }
    $i++;  
  }

  return 'true';  
}