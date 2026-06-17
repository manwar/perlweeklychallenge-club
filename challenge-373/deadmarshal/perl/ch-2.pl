#!/usr/bin/env perl
use strict;
use warnings;
use Data::Show;

sub list_division{
  my ($arr,$n) = @_;
  my $sz = int(@$arr / $n);
  return -1 if $n > @$arr;

  my $rest = @$arr % $n;
  my @res;
  foreach my $i(1..$n){
    push @res,[splice @$arr,0,$sz + ($i <= $rest)]
  }
  @res
}

show list_division([1..5],2);
show list_division([1..6],3);
show list_division([1..3],2);
show list_division([1..10],5);
show list_division([1..3],4);
show list_division([72,57,89,55,36,84,10,95,99,35],7);

