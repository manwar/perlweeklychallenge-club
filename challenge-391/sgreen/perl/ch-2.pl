#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

use Algorithm::Combinatorics 'combinations';
use List::Util qw(any pairs uniq zip);

use constant WIDTH  => 0;
use constant HEIGHT => 1;

sub stackable_box($boxes) {
    # Check the widths and heights are unique
    my $box_count = scalar(@$boxes);
    if ( scalar( uniq map { $_->[WIDTH] } @$boxes ) != $box_count ) {
        return undef;
    }
    if ( scalar( uniq map { $_->[HEIGHT] } @$boxes ) != $box_count ) {
        return undef;
    }

    # Sort boxes by their width, and make sure their heights are in order
    my @sorted_boxes   = sort { $a->[WIDTH] <=> $b->[WIDTH] } @$boxes;
    my @heights        = map  { $_->[HEIGHT] } @sorted_boxes;
    my @sorted_heights = sort { $a <=> $b } @heights;
    if ( any { $_->[0] != $_->[1] } zip( \@heights, \@sorted_heights ) ) {
        return undef;
    }

    # They are stackable
    return 1;
}

sub main (@args) {
    my @boxes = pairs(@args);
    for ( my $length = $#boxes + 1 ; $length > 1 ; $length-- ) {
        my $iter = combinations( \@boxes, $length );
        while ( my $box_set = $iter->next() ) {
            if ( stackable_box($box_set) ) {
                say $length;
                return;
            }
        }
    }

    say "1";
}

main(@ARGV);
