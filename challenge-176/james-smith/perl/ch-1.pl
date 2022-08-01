#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);

for (1..1000){
my $t=123_455;

O: while( my $z = join '', sort split //, ++$t ) {
  ( $z eq join '', sort split //, $_*$t ) || next O for 2..6;
  last;
}

say $t;
}
