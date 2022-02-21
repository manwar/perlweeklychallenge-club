#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);

say my $t = my $f = 1;
say $t += ($f*=$_) for 1..20;
