#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

is( jump_game( qw(1 3 1 2)   ), 1 ); ## 0 -> 1 -> 4 (escaped)
is( jump_game( qw(2 1 1 0 2) ), 0 ); ## 0 -> 2 -> 3 (hit hole)

done_testing();

sub jump_game {
  my $ptr = 0;
  $ptr += $_[$ptr] while $ptr < @_ && $_[$ptr];
  return $ptr < @_ ? 0 : 1;
}

