#!/usr/bin/env perl
use strict;
use warnings;

sub maximum_pairs{
  my ($a) = @_;
  my $c = 0;
  map{my $i = $_;
      map{$c++ if $a->[$i] eq reverse $a->[$_]}$i+1..$#$a}0..$#$a;
  $c
}

printf "%d\n", maximum_pairs(['ab','de','ed','bc']);
printf "%d\n", maximum_pairs(['aa','ba','cd','ed']);
printf "%d\n", maximum_pairs(['uv','qp','st','vu','mn','pq']);

