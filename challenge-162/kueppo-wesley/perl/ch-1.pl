#!/usr/bin/env perl

use strict;
use feature 'say';
use v5.10;

my $ps;

$ps += $_ * &oot foreach (split /-|/, $ARGV[0]);
$ps %= 10;
$ps =~ s/[^0]/10 - $ps/e;

say "$ARGV[0]-$ps";

sub oot { state $x = 3; $x = ($x == 3 ? 1 : 3) }

## input  : 978-0-306-40615
## output : 978-0-306-40615-7

