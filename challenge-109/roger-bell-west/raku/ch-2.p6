#! /usr/bin/perl6

use Test;

plan 3;

{
  my @q=foursquare(1..7);
  is(@q[0],@q[2]+@q[3],'test 1');
  is(@q[1]+@q[2],@q[4]+@q[5],'test 2');
  is(@q[3]+@q[4],@q[6],'test 3');
}

sub foursquare(@in) {
  my @sol;
  for @in.permutations -> @t {
    my $b=@t[1]+@t[2]+@t[3];
    if (@t[0]+@t[1]==$b) {
      my $c=@t[3]+@t[4]+@t[5];
      if ($b==$c && $c == @t[5]+@t[6]) {
        @sol=@t;
        last;
      }
    }
  }
  return @sol;
}
