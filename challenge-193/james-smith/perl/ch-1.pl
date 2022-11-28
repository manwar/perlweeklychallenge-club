#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);

say join ', ', binary($_) for 1..10;

sub binary {
  my $t = "%0$_[0]b";
  map { sprintf $t, $_ } 0.. (1<<$_[0])-1
}
