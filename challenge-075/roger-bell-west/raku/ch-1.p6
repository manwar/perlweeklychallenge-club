#! /usr/bin/perl6

use Test;

plan 1;

is(coinsum((1,2,4),6),
   6,
   "example");

sub coinsum(@c,$s) {
  my @m;
  for (0..@c.end) {
    push @m,floor($s/@c[$_]);
  }
  my @out;
  my @b=(0) xx @c.elems;
  my $of=1;
  while ($of) {
    my $v=sum(map {@c[$_]*@b[$_]}, (0..@c.end));
    if ($v==$s) {
      push @out,@b.clone;
    }
    my $i=0;
    while (1) {
      @b[$i]++;
      if (@b[$i]>@m[$i]) {
        @b[$i]=0;
        $i++;
        if ($i>@b.end) {
          $of=0;
          last;
        }
      } else {
        last;
      }
    }
  }
  return @out.elems;
}
