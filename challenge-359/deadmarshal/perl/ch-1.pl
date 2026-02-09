#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(sum0);

sub digital_root {
  my ($n) = @_;
  my $c = 0;
  $c++, $n = sum0 split '',$n while $n > 9;
  printf "Persistence  = %d\nDigital Root = %d\n",$c,$n
}

digital_root(38);
digital_root(7);
digital_root(999);
digital_root(1999999999);
digital_root(101010);

