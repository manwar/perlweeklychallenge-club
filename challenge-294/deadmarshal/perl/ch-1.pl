#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(max);
use Set::Scalar;

sub consecutive_sequence{
  my ($arr) = @_;
  my $s = Set::Scalar->new(@$arr);
  my $res = 0;
  foreach my $i(0..$#$arr){
    unless($s->has($arr->[$i]-1)){
      my $j = $arr->[$i];
      $j++ while($s->has($j));
      $res = max($res,$j - $arr->[$i])
    }
  }
  $res == 1 ? -1 : $res
}

printf "%d\n",consecutive_sequence([10,4,20,1,3,2]);
printf "%d\n",consecutive_sequence([0,6,1,8,5,2,4,3,0,7]);
printf "%d\n",consecutive_sequence([10,30,20]);

