#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

use List::Util qw(any mesh zip);

sub main (@args) {
    # Take the input and process is
    my $composer  = shift(@args);
    my $split_pos = ( $#args + 1 ) / 2;
    my @notes     = @args[ 0 .. $split_pos - 1 ];
    my @positions  = @args[ $split_pos .. $#args ];

    # Validate input
    if ( $#notes != $#positions ) {
        die "The two lists must be the same length\n";
    }
    if ( any { $_ !~ /^[A-G][♯♭#b]?$/ } @notes ) {
        die "Invalid note\n";
    }
    if ( any { $_->[0] != $_->[1] }
        zip( [ 1 .. $#notes + 1 ], [ sort { $a <=> $b } @positions ] ) )
    {
        die "Missing position\n";
    }

    # Turn a dict of position and note
    my %music = mesh \@positions, \@notes;

    # Sort the notes by their position and return the required string
    my @ordered_music = map { $music{$_} } sort { $a <=> $b } keys %music;
    say uc($composer) . " => " . join( " ", @ordered_music );
}

main(@ARGV);
