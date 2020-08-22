#!/usr/bin/env perl
# -*- Mode: cperl; cperl-indent-level:4 tab-width: 8; indent-tabs-mode: nil -*-
# -*- coding: utf-8 -*-

use strict; use warnings;

sub unique {
    scalar @_ or return ();
    $_[0], map { $_[0] ne $_ ? $_: () } @_[1..$#_];
}

# adapted from my own solution in common-lisp which is a bit lengthy
sub printLNR {
    my $str = shift;
    for my $last_idx ( 1 .. length $str ) {
        my $sub_chars = substr $str, 0, $last_idx;
        my @candi = unique( split '', $sub_chars );

        my ( $nr_pos, $nr_chr )  = ( -1, '#' );

        for my $c ( @candi ) {
            next if ( my $pos1 = index $sub_chars, $c ) == -1;
            next if ( my $pos2 = index $sub_chars, $c, $pos1 + 1 ) != -1;
            $nr_pos < $pos1 and ( $nr_pos = $pos1, $nr_chr = $c );
        }
        print "$nr_chr";
    }
    print $/;
}

# posted on 20th of Aug
sub printLNR_by_split ($) {
    my $str = shift;

    for my $last_idx ( 1 .. length $str ) {
        my $sub_chars = substr $str, 0, $last_idx;
        my @candi = unique( split '', $sub_chars );

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
