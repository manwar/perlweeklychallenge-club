#!/usr/bin/env perl
use strict;
use warnings;

sub is_inside{
  $_[0] >= 0 && $_[0] <= $_[2]
    && $_[1] >= 0 && $_[1] <= $_[2]
}

sub min_steps{
  my ($k1,$k2,$t1,$t2,$n) = @_;
  my @dirs = ([-2,1],[-1,2],[1,2],[2,1],
	      [2,-1],[1,-2],[-1,-2],[-2,-1]);
  my (@queue,@visited);
  push @queue,[$k1,$k2,0];
  while(@queue){
    my $t = shift @queue;
    return $t->[2] if $t->[0] == $t1 && $t->[1] == $t2;
    foreach my $i(0..$#dirs){
      my $x = $t->[0] + $dirs[$i][0];
      my $y = $t->[1] + $dirs[$i][1];
      if(is_inside($x,$y,$n)){
	$visited[$x][$y] = 1;
	push @queue,[$x,$y,$t->[2]+1]
      }
    }
  }
  -1
}

sub knights_move{
  my ($s,$e) = @_;
  my ($k1,$k2,$t1,$t2) = (ord(substr($s,0,1)) - ord('a'),
			  substr($s,1,1) - '0',
			  ord(substr($e,0,1)) - ord('a'),
			  substr($e,1,1) - '0');
  min_steps($k1,$k2,$t1,$t2,8)
}

printf "%d\n",knights_move('g2','a8');
printf "%d\n",knights_move('g2','h2');

