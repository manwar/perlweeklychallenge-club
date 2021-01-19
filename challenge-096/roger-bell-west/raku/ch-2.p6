#! /usr/bin/perl6

use Test;

plan 3;

is(ed('kitten','sitting'),3,'example 1');
is(ed('sunday','monday'),2,'example 2');
is(ed('branscombe','ranscombe'),1,'example 3');

sub ed($s,$t) {
  my @ss=(0,$s.comb).flat;
  my @tt=(0,$t.comb).flat;
  my @d;
  for 0..@ss.end {
    push @d,[(0) xx (@tt.elems)];
  }
  map {@d[$_][0]=$_}, 1..@ss.end;
  map {@d[0][$_]=$_}, 1..@tt.end;
  for 1..@tt.end -> $j {
    for 1..@ss.end -> $i {
      my $sc=0;
      if (@ss[$i] ne @tt[$j]) {
        $sc=1;
      }
      @d[$i][$j]=min(
        @d[$i-1][$j]+1,
        @d[$i][$j-1]+1,
        @d[$i-1][$j-1]+$sc,
          );
    }
  }
  return @d[@ss.end][@tt.end];
}
