#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(all);

sub balls_and_boxes{
  my ($sum,%h) = (0);
  $h{$2} .= $1 while($_[0] =~ /([RGB])(\d)/g);
  foreach my $v(values %h){
    $sum++ if all{index($v,$_) != -1} ('R','G','B')
  }
  $sum
}

printf "%d\n",balls_and_boxes('G0B1R2R0B0');
printf "%d\n",balls_and_boxes('G1R3R6B3G6B1B6R1G3');
printf "%d\n",balls_and_boxes('B3B2G1B3');

