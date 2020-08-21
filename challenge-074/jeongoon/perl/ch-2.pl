#!/usr/bin/env perl
# -*- Mode: cperl; cperl-indent-level:4 tab-width: 8; indent-tabs-mode: nil -*-
# -*- coding: utf-8 -*-

use strict; use warnings;

sub uniq_sorted {
    my %mem = ();
    map { exists $mem{$_} ? () : ($mem{$_} = $_) } @_
}

sub printLNR ($) {
    my $str = shift;

    for my $last_idx ( 1 .. length $str ) {
        my $sub_chars = substr $str, 0, $last_idx;
        my @candi = uniq_sorted( split '', $sub_chars );

        my $nr_pos = -1;
        my $nr_chr = '#';
        for my $c ( @candi ) {
            my @chunks = split $c, "$sub_chars\0";
            next unless @chunks == 2;

            my $new_pos = length $chunks[0];
            $nr_pos < $new_pos and ( $nr_pos = $new_pos,
                                     $nr_chr = $c );
        }
        print "$nr_chr";
    }
    print $/;
}

*printFNR = \&printLNR;

package main;

my $sample = $ARGV[0] ||'xyzzyx';
print "Input:  $sample\n";
print "Output: ";
printFNR( $sample );
