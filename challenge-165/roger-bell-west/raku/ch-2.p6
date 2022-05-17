#! /usr/bin/perl6

my @points;

for lines() {
  .chomp;
  for split(' ',$_,:skip-empty) -> $pp {
    if ($pp ~~ /\S/) {
      say $pp;
      push @points,map {0+$_},split(',',$pp);
    }
  }
}

my @slope;
for (0..@points.end-1) -> $i {
  for ($i+1..@points.end) -> $j {
    if (@points[$i][0] != @points[$j][0]) {
      push @slope,(@points[$j][1]-@points[$i][1])/(@points[$j][0]-@points[$i][0]);
    }
  }
}

my $m = median(@slope);

my $c = median(map {$_[1] - $m*$_[0]}, @points);

my @x=map {$_[0]}, @points;
my @l;
for (min(@x),max(@x)) -> $xb {
  push @l,$xb;
  push @l,$xb*$m+$c;
}

say join(',',@l);

sub median(@s0) {
    my @s=sort @s0;
    return @s[floor(@s.elems/2)];
}
