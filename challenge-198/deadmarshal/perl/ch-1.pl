#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(min max);
use List::MoreUtils qw(slide);

sub max_gap{
  my ($A) = @_;
  return 0 if @$A < 2;
  @$A = sort {$a <=> $b} @$A;
  my $max = max @$A - min @$A;
  scalar grep {$_ == 1} slide {$b - $a == $max} @$A;
}

printf "%d\n", max_gap([2,5,8,1]);
printf "%d\n", max_gap([3]);

