#!/usr/bin/env raku

sub maximum-frequency(@arr) 
{
  my %h;
  %h{$_}++ for @arr;
  my $max = %h.values.max;
  (%h.values.grep: {$_ if $_ == $max}).sum;
}

printf "%d\n",maximum-frequency([1,2,2,4,1,5]);
printf "%d\n",maximum-frequency([1,2,3,4,5]);

