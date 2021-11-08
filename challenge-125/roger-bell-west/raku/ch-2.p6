#! /usr/bin/perl6

use Test;

plan 1;

is(btd([1,
        2,5,
        3,4,6,7,
        0,0,0,0,0,0,8,10,
        0,0,0,0,0,0,0,0,0,0,0,0,9,0,0,0]),6,'example 1');

sub btd(@tree) {
  my $st=@tree.elems;
  my @depth=(0) xx $st;
  my @diameter=(0) xx $st;
  loop (my $i=$st-1;$i>=0;$i--) {
    if (@tree[$i] != 0) {
      my $a=$i*2+1;
      my $b=$a+1;
      if ($b < $st) {
        @depth[$i]=1+max(@depth[$a],@depth[$b]);
        @diameter[$i]=max(@depth[$a]+@depth[$b],
                          @diameter[$a],
                          @diameter[$b]);
      } else {
        @depth[$i]=1;
      }
    }
  }
  return @diameter[0];
}
