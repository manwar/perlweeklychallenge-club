#! /usr/bin/perl6

use Test;
plan 4;

is-deeply(lcs((100, 4, 50, 3, 2)),[2,3,4],'example 1');
is-deeply(lcs((20, 30, 10, 40, 50)),0,'example 2');
is-deeply(lcs((20, 19, 9, 11, 10)),[9,10,11],'example 3');
is-deeply(lcs([20, 19, 18, 11, 10]),[18,19,20],'example 4');

sub lcs(@ns) {
  my @l=sort {$^a <=> $^b}, @ns;
  my @w;
  my @r;
  while (my $n = shift @l) {
    if ((@w.elems == 0) || $n==@w[@w.end]+1) {
      push @w,$n;
    } else {
      if (@w.elems > @r.elems) {
        @r=@w;
      }
      @w=($n);
    }
  }
  if (@w.elems > @r.elems) {
    @r=@w;
  }
  if (@r.elems > 1) {
    return @r;
  } else {
    return 0;
  }
}
