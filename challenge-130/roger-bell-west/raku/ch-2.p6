#! /usr/bin/perl6

use Test;

plan 2;

is(bst([
               8,
           5,      9,
         4,  6,  0,  0
          ]),1,'example 1');

is(bst([
               5,
           4,      7,
         3,  6,  0,  0
          ]),0,'example 2');

sub bst(@tree) {
  my @limit;
  loop (my $s=floor((@tree.end)/2)-1;$s>=0;$s--) {
    my $child=$s*2+1;
    for (0,1) -> $sb {
      my $ac=$child+$sb;
      unless (@limit[$ac][0].defined()) {
        @limit[$ac]=[@tree[$ac],@tree[$ac]];
      }
      if ($sb==0 && @tree[$s] != 0 && @limit[$ac][1] > @tree[$s]) {
        return 0;
      }
      if ($sb==1 && @limit[$ac][0] != 0 && @limit[$ac][0] < @tree[$s]) {
        return 0;
      }
    }
    @limit[$s]=[min(@tree[$s],@limit[$child][0] || @tree[$s]),max(@tree[$s],@limit[$child+1][1])];
  }
  return 1;
}
