#!/usr/bin/env perl
# -*- Mode: cperl; cperl-indent-level:4 tab-width: 8; indent-tabs-mode: nil -*-
# -*- coding: utf-8 -*-

use strict; use warnings;
use v5.26;

# tested with: perl ch-1.pl 10 -5 -15 20 30

my ($A, @N ) = @ARGV;

$A < 0 and die "difference between integers cannot be negative";

my @n = sort @N;

for ( my $i = 1; $i < scalar @n; ) {
    for ( ($n[$i] - $n[0]) <=> abs $A ) {
        if    ( $_ == -1 ) { ++$i }
        elsif ( $_ ==  1 ) { shift @n; $i = 1 }
        else  { say "1 as $n[$i] - $n[0] = $A"; exit 0 }
    }
}

say "0";
exit 1;
