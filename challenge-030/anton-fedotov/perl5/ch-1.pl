#!/usr/bin/env perl
use strict;
use warnings;
use v5.10;

my %dweeks = ( Sunday => 1, Monday => 2, Tuesday => 3, Wednesday => 4, 
                Thursday => 5, Friday => 6, Saturday => 7 );

sub list_rep_years {
    my ($start_y, $end_y, $start_dweek, $dweek) = @_;
    my ( $dweek_count, @rep_years ) = $start_dweek;
    for ( $start_y + 1 .. $end_y ) {
        if ( ($_ % 4 == 0 && $_ % 100 != 0) || $_ % 400 == 0 ) { $dweek_count += 2; }
        else { $dweek_count++; }
        $dweek_count %= 7 if $dweek_count > 7;
        push ( @rep_years, $_ ) if $dweek_count == $dweek;
    }
    return @rep_years;
}

sub find_sunday_christmas_years {
    my ( $start_y, $end_y, $date) = ( 2019, 2100, '25 December');

    my ( $start_year_dweek, $finding_years_dweek ) = ( $dweeks{'Wednesday'}, $dweeks{'Sunday'} );

    my @years = list_rep_years( $start_y, $end_y, $start_year_dweek, $finding_years_dweek );

    foreach (@years) { print "25 Dec $_ is Sunday\n"; }
}

find_sunday_christmas_years();

