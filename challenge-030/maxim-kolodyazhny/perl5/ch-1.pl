#!/usr/bin/env perl

use strict;
use warnings;

sub same_wday {
    my ( $year, $up_to ) = @_;

    my %how_many2skip = (
        0 => 28,
        1 => 6,
        2 => 11,
        3 => 11,
    );

    while ( $year <= $up_to ) {
        print "$year\n";
        $year +=  $how_many2skip{ $year % 4 };
    }
}

same_wday ( 2022, 2100 );
