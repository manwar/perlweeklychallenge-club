#!/usr/bin/env perl
use strict;
use warnings;

sub increment_decrement{
  my $x = 0;
  map{/\+\+/ ? $x++ : $x--} @{$_[0]};
  $x
}

printf "%d\n",increment_decrement(["--x","x++","x++"]);
printf "%d\n",increment_decrement(["x++","++x","x++"]);
printf "%d\n",increment_decrement(["x++","++x","--x","x--"]);

