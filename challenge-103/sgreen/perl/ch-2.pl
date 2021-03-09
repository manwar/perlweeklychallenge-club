#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

use Text::CSV 'csv';
use List::Util 'sum';

sub main {
    my ( $start, $now, $file ) = @_;

    # Sanity check
    die "You must enter the start time\n"                             unless $start;
    die "You must enter the current time\n"                           unless $now;
    die "You must enter the file name\n"                              unless $file;
    die "The start time must be an integer (seconds since epoch)\n"   unless $start =~ /^\d+$/;
    die "The current time must be an integer (seconds since epoch)\n" unless $now =~ /^\d+$/;
    die "The current time cannot be earlier than the start time\n" if $now < $start;
    die "The file '$file' does not exist (or is not a file)\n" unless -f $file;

    # Read the CSV file, and find out the total length
    my $tracks          = csv( { in => $file } );
    my $playlist_length = sum( map { $_->[0] } @$tracks );

    # Find out how far through the playlist we are
    my $playlist_position = ( $now - $start ) * 1000 % $playlist_length;

    # Work through the play list to see what song is playing
    while ( my $row = shift @$tracks ) {
        my ( $track_length, $track_name ) = @$row;
        if ( $track_length <= $playlist_position ) {
            $playlist_position -= $track_length;
            next;
        }

        # We are playing this track. Get the number of seconds we are into the track and display this
        my $secs = int( $playlist_position / 1000 );
        say sprintf '%s %02d:%02d:%02d', $track_name, int( $secs / 3_600 ), int( $secs % 3_600 / 60 ), $secs % 60;
        last;
    }
}

main(@ARGV);
