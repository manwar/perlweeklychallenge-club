#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::MoreUtils 'first_index';

sub main ($input_string) {
    my @DAYS = (
        "1st",  "2nd",  "3rd",  "4th",  "5th",  "6th",  "7th",  "8th",
        "9th",  "10th", "11th", "12th", "13th", "14th", "15th", "16th",
        "17th", "18th", "19th", "20th", "21st", "22nd", "23rd", "24th",
        "25th", "26th", "27th", "28th", "29th", "30th", "31st"
    );

    my @MONTHS = (
        "Jan", "Feb", "Mar", "Apr", "May", "Jun",
        "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    );

    my @YEARS = ( 1900 .. 2100 );

    my @fields = (
        [ "day of month", \@DAYS,   1 ],
        [ "month",        \@MONTHS, 1 ],
        [ "year",         \@YEARS,  1900 ],
    );

    my @input_array  = split /\s+/, $input_string;
    my @output_array = ();

    if ( $#input_array != 2 ) {
        die "Input must contain day, month, and year\n";
    }

    foreach my $i ( 0, 1, 2 ) {
        my ( $name, $values, $offset ) = @{ $fields[$i] };
        my $value = $input_array[$i];

        my $idx = first_index { $_ eq $value } @$values;
        if ( $idx == -1 ) {
            die "Invalid $name: $value\n";
        }

        push @output_array, sprintf( "%02d", $idx + $offset );
    }

    say join( "-", reverse @output_array );
}

main(@ARGV);
