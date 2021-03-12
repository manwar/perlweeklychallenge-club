#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ postderef say signatures state };
no warnings qw{ experimental };

use Carp;
use Text::CSV qw( csv );
use Getopt::Long;
my $starttime = 1606134123;    # 2020-11-23 12:22:03
my $currtime  = 1614591276;    # 2021-03-01 09:34:36
my $file      = 'input.csv';

my $np = now_playing( $starttime, $currtime, $file );
say join "\n\t", $np->@*;

sub now_playing ( $starttime, $currtime, $file ) {
    croak 'Bad Times'     unless $currtime > $starttime;
    croak 'No Input File' unless -f $file;

    # $starttime is when the streaming started
    # $currtime is the time during the stream we're asking about
    # $endtime is the total time in seconds that the streamer
    #       has been running
    my $endtime = $currtime - $starttime;
    my @data    = get_data($file);

    # 4:50pm - Restate my assumptions
    #   One:    Mathematics is the language of nature.
    #   Two:    Everything around us can be represented
    #           and understood through numbers.
    #   Three:  The streamer adds no time between recordings,
    #           nor crossfades between trackss, so there is no
    #           time unaccounted for between tracks
    #   Four:   The streamer will get to the end of the list and
    #           start all over again
    #   Five:   Pi is a movie that every developer of a certain age
    #           will recognize immediately
    #   Six:    Current time will be higher than start time, meaning
    #           we're not querying the past
    #   Seven:  The episodes in the CSV are roughly a half-hour each

    #   Hypothesis:
    #       We can subtract the start time from the time in
    #       question to find the total number of seconds that
    #       the streamer has played, then go through the whole
    #       playlist over and over until the current total is
    #       less than the run time, but the current total plus
    #       the next media file would be greater than the run
    #       time. This would indicate that this is the currently
    #       streaming file

    my $ctime = 0;
    while (1) {
        for my $c ( 0 .. -1 + scalar @data ) {
            my $row = $data[$c];
            my ( $mill, $name ) = $row->@*;
            my $length = $mill / 1000;
            my $c2     = $ctime;
            $ctime += $length;
            if ( $ctime >= $endtime && $c2 <= $endtime ) {
                my $time      = int $endtime - $c2;
                my $formatted = join ':',
                    ( int $time / 60 ),
                    ( sprintf '%02d', $time % 60 );
                my @output = ( $row->[1], $formatted );
                return \@output;
            }
        }
    }
    croak 'This should never happen';
}

# getting to the CSV is a separate function for ease
sub get_data ($file=undef) {
    $file //= 'input.csv';
    if ( -f $file ) {
        my $data = csv( in => $file );
        return $data->@*;
    }
    else {
        croak 'no data';
    }
}

