#!/usr/bin/env perl
use strict;
use warnings;

sub champion_team{
  my $m = 0;
  my %h;
  foreach my $y(0..$#{$_[0]}){
    foreach my $x(0..$#{$_[0]->[$y]}){
      my $w = $_[0]->[$y][$x] ? $y : $x;
      $m = $w if ++$h{$w} > $h{$m}
    }
  }
  $m
}

printf "%d\n",champion_team([[0, 1, 1],
			     [0, 0, 1],
			     [0, 0, 0]]);
printf "%d\n",champion_team([[0, 1, 0, 0],
			     [0, 0, 0, 0],
			     [1, 1, 0, 0],
			     [1, 1, 1, 0]]);
printf "%d\n",champion_team([[0, 1, 0, 1],
			     [0, 0, 1, 1],
			     [1, 0, 0, 0],
			     [0, 0, 1, 0]]);
printf "%d\n",champion_team([[0, 1, 1],
			     [0, 0, 0],
			     [0, 1, 0]]);
printf "%d\n",champion_team([[0, 0, 0, 0, 0],
			     [1, 0, 0, 0, 0],
			     [1, 1, 0, 1, 1],
			     [1, 1, 0, 0, 0],
			     [1, 1, 0, 1, 0]]);

