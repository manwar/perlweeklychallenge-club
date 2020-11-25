#!/usr/bin/env perl6
use v6;

sub tr_es($s) { my $trs = S:g/e/E/ with $s; $trs, $/.elems }

say tr_es( @*ARGS[0] || 'Perl Weekly Challenge' )

# run as <script> <string surrounded by quotes> or just <script> to default to 'Perl Weekly Challenge'
