#! /usr/bin/perl6

# Write a program to solve Knapsack Problem.
# (specifically 0-1 knapsack)

my %box=(
  R => {w => 1, v => 1},
  B => {w => 1, v => 2},
  G => {w => 2, v => 2},
  Y => {w => 12, v => 4},
  P => {w => 4, v => 10},
    );

my @k=%box.keys;
my @v=map {2**$_}, (0..@k.end);
my $maxw=15;
my $maxb=@k.elems;

# $maxb=3;

my $bestv=0;
my $bestw=0;
my $bestid=0;

for (1..2**(@k.elems)-1) -> $map {
  my $b=0;
  my $v=0;
  my $w=0;
  for (0..@k.end) -> $ci {
    if ($map +& @v[$ci]) {
      $v += %box{@k[$ci]}{'v'};
      $w += %box{@k[$ci]}{'w'};
      $b++;
    }
    if ($b>$maxb || $w>$maxw) {
      $v=-1;
      last;
    }
  }
  if ($v>0) {
    if ($v>$bestv || ($v==$bestv && $w>$maxw)) {
      $bestv=$v;
      $bestw=$w;
      $bestid=$map;
    }
  }
}

for (0..@k.end) -> $ci {
  if ($bestid +& @v[$ci]) {
    print @k[$ci],"\n";
  }
}
print "$bestv in $bestw\n";
