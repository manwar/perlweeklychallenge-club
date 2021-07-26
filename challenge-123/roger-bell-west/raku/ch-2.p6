#! /usr/bin/perl6

use Test;

plan 4;

is(sp([
  [10,20],
  [20,20],
  [20,10],
  [10,10],
    ]),1,'example 1');

is(sp([
  [12,24],
  [16,10],
  [20,12],
  [18,16],
    ]),0,'example 2');

is(sp([
  [10,10],
  [20,0],
  [30,10],
  [20,20],
    ]),1,'example 3');

is(sp([
  [0,0],
  [3,4],
  [8,4],
  [5,0],
    ]),0,'example 4');

sub sp(@m) {
  for ([0,1,2,3,0],[0,1,3,2,0],[0,2,1,3,0]) -> @ordering {
    my @w=map {@m[@ordering[$_ % 4]]},(0..4);
    # check for equal sides
    my @ds;
    for (0..3) -> $pp {
      push @ds,(@w[$pp+1][0]-@w[$pp][0])**2+(@w[$pp+1][1]-@w[$pp][1])**2;
    }
    if (min(@ds) != max(@ds)) {
      next;
    }
    # check for equal right angles
    my @angles;
    for 0..3 -> $pp {
      my @delta=map {@w[$pp+1][$_]-@w[$pp][$_]},(0,1);
      my $angle;
      if (@delta[0]==0) {
        if (@delta[1]==0) {     # coincident points
          return 0;
        }
        $angle=@delta[1]>0 ?? 90 !! -90;
      } else {
        $angle=atan2(@delta[1],@delta[0])*180/pi;
      }
      push @angles,$angle;
    }
    push @angles,@angles[0];
    my $good=1;
    my @deltas=map {(@angles[$_+1]-@angles[$_]+360)%360},(0..3);
    if (@deltas[0] != 90 && @deltas[0] != 270) {
      next;
    } else {
      for 1..3 -> $di {
        if (@deltas[$di] != @deltas[0]) {
          $good=0;
          last;
        }
      }
    }
    return $good;
  }
  return 0;
}

sub eqish($a,$b) {
  if ((abs($a-$b)/$a) < 0.0001) {
    return 1;
  } else {
    return 0;
  }
}