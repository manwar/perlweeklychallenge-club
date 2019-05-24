#!/usr/bin/env perl6
use v6;

#
# Copyright © 2019 Joelle Maslak
# All Rights Reserved - See License
#

my $seq = (0..∞).map( *² ).grep( { .comb.sort eq .comb.unique.sort } ).grep( *.chars ≥ 5 );
say $seq[0];

