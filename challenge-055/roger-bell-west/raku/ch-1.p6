#! /usr/bin/perl6

my $b=@*ARGS[0] || '010';

my @res;
my $mx=0;

my @b=$b.comb(/./);
for (0..@b.end) -> $l {
  my $la=0;
  if ($l>0) {
    $la=@b[0..$l-1].grep(/1/).elems;
  }
  for ($l..@b.end) -> $r {
    my $ma=@b[$l..$r].grep(/0/).elems;
    my $ra=0;
    if ($r < @b.end) {
      $ra=@b[$r+1..@b.end].grep(/1/).elems;
    }
    my $a=$la+$ma+$ra;
    if ($a > $mx) {
      @res=();
    }
    if ($a >= $mx) {
      $mx=$a;
      push @res,[$l,$r];
    }
  }
}

for @res -> $r {
  say "(L=$r.[0], R=$r.[1])";
}
