#!/usr/bin/env perl
use strict;
use warnings;

sub to_min{
  my @parts = split ':',$_[0];
  $parts[0] * 60 + $parts[1]
}

sub convert_time{
  my $diff = (to_min($_[1]) - to_min($_[0]) + 1440) % 1440;
  my $res = 0;
  foreach my $i(qw(60 15 5 1)) {
    $res += $diff / $i;
    $diff %= $i
  }
  $res
}

printf "%d\n",convert_time('02:30','02:45');
printf "%d\n",convert_time('11:55','12:15');
printf "%d\n",convert_time('09:00','13:00');
printf "%d\n",convert_time('23:45','00:30');
printf "%d\n",convert_time('14:20','15:25')

