#! /usr/bin/perl6

use Test;

plan 2;

is-deeply(sm((
  [ 1, 2, 3 ],
  [ 4, 5, 6 ],
  [ 7, 8, 9 ],
    )),(1, 2, 3, 6, 9, 8, 7, 4, 5),'example 1');
is-deeply(sm((
  [  1,  2,  3,  4 ],
  [  5,  6,  7,  8 ],
  [  9, 10, 11, 12 ],
  [ 13, 14, 15, 16 ],
    )),(1, 2, 3, 4, 8, 12, 16, 15, 14, 13, 9, 5, 6, 7, 11, 10),'example 2');

sub sm(@m) {
  my $mx=@m.elems;
  my $my=@m[0].elems;
  my @o=(@m[0][0]);
  my @v;
  for 1..$mx {
    push @v,[(0) xx $my];
  }
  my @dir=(
    [0,1],
    [1,0],
    [0,-1],
    [-1,0],
      );
  my ($x,$y,$d)=(0,0,0);
  for 2..$mx*$my {
    @v[$x][$y]=1;
    my ($nx,$ny);
    while (1) {
      ($nx,$ny)=($x+@dir[$d][0],$y+@dir[$d][1]);
      if ($nx < 0 || $nx >= $mx || $ny < 0 || $ny >= $my || @v[$nx][$ny]==1) {
        $d++;
        $d%=4;
      } else {
        last;
      }
    }
    ($x,$y)=($nx,$ny);
    push @o,@m[$x][$y];
  }
  return @o.List;
}
