#! /usr/bin/perl6

my @in=([1,2,3],
        [4,5,6],
        [7,8,9],
          );

my @out=rotate(1,@in);

for @out -> @r {
  print '[ ' ~ join(', ',@r) ~ " ]\n";
}

sub rotate {
  my ($rotations,@in)=@_;
  my $xs=@in.end;
  for @in -> @ya {
    if (@ya.end != $xs) {
      die "not a square matrix\n";
    }
  }
  my @out=@in;
  for 1..$rotations {
    my @im=@out;
    my @tmp;
    for 0..$xs -> $x {
      for 0..$xs -> $y {
        @tmp[$y][$xs-$x]=@im[$x][$y];
      }
    }
    @out=@tmp;
  }
  return @out;
}
