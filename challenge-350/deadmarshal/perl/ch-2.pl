#!/usr/bin/env perl
use strict;
use warnings;

sub shuffle_pairs{
  my ($from,$to,$count) = @_;
  my $found = 0;
  foreach my $n($from..$to){
    my $c = 0;
    my $s = join '',sort split '',$n;
    foreach my $w(2..9){
      my $m = $n * $w;
      next if length $m > length $n;
      next if $s ne join '',sort split '',$m;
      ++$c
    }
    ++$found if $c >= $count
  }
  $found
}

printf "%d\n",shuffle_pairs(1,1000,1);
printf "%d\n",shuffle_pairs(1500,2500,1);
printf "%d\n",shuffle_pairs(1_000_000,1_500_000,5);
printf "%d\n",shuffle_pairs(13_427_000,14_100_000,2);
printf "%d\n",shuffle_pairs(1030,1130,1);

