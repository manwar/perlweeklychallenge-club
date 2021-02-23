#! /usr/bin/perl6

use Test;

plan 3;

is-deeply(ot([[0,1],[1,0],[2,2]]),0,'example 1');
is-deeply(ot([[1,1],[-1,1],[0,-3]]),1,'example 2');
is-deeply(ot([[0,1],[2,0],[-6,0]]),1,'example 3');

sub ot(@points) {
  my @pp=@points;
  push @pp,@points[0];
  my @xp;
  for (0..2) -> $i {
    push @xp,(@pp[$i][0] *
                (@pp[$i+1][1]-@pp[$i][1]))
      -
      (@pp[$i][1] *
       (@pp[$i+1][0]-@pp[$i][0]));
  }
  @xp=sort @xp;
  if (@xp[0] <=0 && @xp[2] <=0) {
    return 1;
  }
  if (@xp[0] >=0 && @xp[2] >=0) {
    return 1;
  }
  return 0;
}
