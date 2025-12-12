#!/usr/bin/env perl

use 5.018;
use strict;
use warnings;
use Test2::V0;

plan tests => 5;

sub meeting_point {
    my $path       = shift;
    my %path_count = ( U => 0, D => 0, L => 0, R => 0 );

    print "$path\n";

    my $result = 'false';
    STEP:
    while ( $path =~ m|(.)|g ) {
        my $step = $1;
        $path_count{ $step }++;

        if (     ( $path_count{ U } == $path_count{ D } )
              && ( $path_count{ L } == $path_count{ R } ) )
        {
            $result = 'true';
            last STEP;
        }
    }
    say $result;

    return $result;
}

is( meeting_point('ULD'),          'false', 'example 1' );
is( meeting_point('ULDR'),         'true',  'example 2' );
is( meeting_point('UUURRRDDD'),    'false', 'example 3' );
is( meeting_point('UURRRDDLLL'),   'true',  'example 4' );
is( meeting_point('RRUULLDDRRUU'), 'true',  'example 5' );
