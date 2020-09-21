#! /usr/bin/perl6

use Test;

plan 2;

is(capacity((2,1,4,1,2,5)),6,'example 1');
is(capacity((3,1,3,1,1,5)),6,'example 2');

histo((2,1,4,1,2,5));
histo((3,1,3,1,1,5));

sub capacity(@n) {
  my $cap=0;
  for (min(@n)..max(@n)) -> $r {
    my @b=grep {@n[$_] >= $r}, (0..@n.end);
    if (@b.elems > 1) {
      for (0..@b.end-1) -> $i {
        $cap += @b[$i+1]-@b[$i]-1;
      }
    }
  }
  return $cap;
}

sub histo(@n) {
  my $mx=max(@n);
  my $cw=floor(log($mx+1)/log(10)+.9999);
  loop (my $r=$mx;$r>0;$r--) {
    my @row=(sprintf('%' ~ $cw ~ 'd',$r));
    push @row,map {(@n[$_]>=$r ?? '#' x $cw !! ' ' x $cw)}, (0..@n.end);
    say join(' ',@row);
  }
  say join(' ',('-' x $cw) xx (1+@n.elems));
  say join(' ',map {sprintf('%' ~ $cw ~ 's',$_)}, ('',@n).flat);
}
