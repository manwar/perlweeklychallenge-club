#!/usr/bin/env perl

use strict;
use warnings;

use v5.22;

use POSIX qw(mktime strftime);

say join "\n", map { strftime( "%Y-%m-%d", gmtime($_) ) }
  grep { ( gmtime($_) )[6] == 0 }
  map { mktime( 0, 0, 0, 25, 11, $_ - 1900 ) } 2020 .. 2100;

