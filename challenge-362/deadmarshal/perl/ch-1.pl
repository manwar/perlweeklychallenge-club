#!/usr/bin/env perl
use strict;
use warnings;

sub echo_chamber{
  my ($s) = @_;
  my @res;
  foreach my $i(0..length($s)-1) {
    push @res,substr($s,$i,1) x ($i+1)
  }
  join '',@res
}

printf "%s\n",echo_chamber('abca');
printf "%s\n",echo_chamber('xyz');
printf "%s\n",echo_chamber('code');
printf "%s\n",echo_chamber('hello');
printf "%s\n",echo_chamber('a');

