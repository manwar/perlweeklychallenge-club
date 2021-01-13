#!/usr/bin/env perl
# -*- Mode: cperl; cperl-indent-level:4 tab-width: 8; indent-tabs-mode: nil -*-
# -*- coding: utf-8 -*-

use strict; use warnings;
use v5.26;

# note: no sanity check !!
my @sorted = sort { $a <=> $b } @ARGV;
push @sorted, $sorted[-1]+2; # dummy

my @longest_seq_list = ();
my $longest_size = 0;

my $prev = shift @sorted;
my @curr_seq = ($prev);

for my $curr (@sorted) {
    if ( $curr - $prev == 1 ) {
        push @curr_seq, ($curr);        # concat. current seq
    } elsif ( $curr == $prev ) {        # skip
    } else {                            # update longest
        my $curr_size = scalar @curr_seq;
        if ( $curr_size > $longest_size ) {
            $longest_size = $curr_size;
            @longest_seq_list = ( [ @curr_seq ] );
        } elsif ( $curr_size == $longest_size ) {
            push @longest_seq_list, [ @curr_seq ];
        }
        @curr_seq = ($curr);
    }
    $prev = $curr;
}

if ( $longest_size > 0 ) {
    say "longest size: ".$longest_size;
    say "total ".(scalar @longest_seq_list)." sequencies found.";
    for my $seq (@longest_seq_list) {
        say "[", join(", ", @$seq), "]";
    }
}
