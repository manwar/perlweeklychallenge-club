#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 1;

sub minutes_light_on {
    my @guest_book = @_;
    my @time_ranges;

    for my $entry (@guest_book) {
        my ( $in_time, $out_time ) = @{$entry}[ 1, 2 ];
        my $in_time_minutes = int( substr( $in_time, 0, 2 ) ) * 60 +
          int( substr( $in_time, 3, 2 ) );
        my $out_time_minutes = int( substr( $out_time, 0, 2 ) ) * 60 +
          int( substr( $out_time, 3, 2 ) );
        push @time_ranges, [ $in_time_minutes, $out_time_minutes ];
    }

    @time_ranges = sort { $a->[0] <=> $b->[0] } @time_ranges;

    my @merged_ranges = ( $time_ranges[0] );

    for my $i ( 1 .. $#time_ranges ) {
        my ( $current_start, $current_end ) = @{ $time_ranges[$i] };
        my ( $last_start,    $last_end )    = @{ $merged_ranges[-1] };

        if ( $current_start > $last_end ) {
            push @merged_ranges, [ $current_start, $current_end ];
        }
        else {
            $merged_ranges[-1] =
              [ $last_start, max( $current_end, $last_end ) ];
        }
    }

    my $total_minutes = 0;
    for my $range (@merged_ranges) {
        $total_minutes += $range->[1] - $range->[0];
    }

    return $total_minutes;
}

sub max {
    return $_[0] > $_[1] ? $_[0] : $_[1];
}

my @guest_book = (
    [ 'Alex',    '09:10', '09:45' ],
    [ 'Arnold',  '09:15', '09:33' ],
    [ 'Bob',     '09:22', '09:55' ],
    [ 'Charlie', '09:25', '10:05' ],
    [ 'Steve',   '09:33', '10:01' ],
    [ 'Roger',   '09:44', '10:12' ],
    [ 'David',   '09:57', '10:23' ],
    [ 'Neil',    '10:01', '10:19' ],
    [ 'Chris',   '10:10', '11:00' ],
);

is( minutes_light_on(@guest_book), 110, "Test minutes_light_on" );
