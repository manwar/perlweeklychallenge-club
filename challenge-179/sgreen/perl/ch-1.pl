#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main ($n) {
    if ( $n >= 10**12 ) {
        die 'Number too large\n';
    }
    my $hundred = $n % 100 == 0;

    my @numbers = (
        undef,     'one',       'two',      'three',
        'four',    'five',      'six',      'seven',
        'eight',   'nine',      'ten',      'eleven',
        'twelve',  'thirteen',  'fourteen', 'fifteen',
        'sixteen', 'seventeen', 'eighteen', 'nineteen'
    );
    my @tens = (
        undef,   undef,     'twenty', 'thirty', 'fourty', 'fifty',
        'sixty', 'seventy', 'eighty', 'ninety'
    );
    my @ordinal = (
        undef,       'first',       'second',     'third',
        'fourth',    'fifth',       'sixth',      'seventh',
        'eighth',    'ninth',       'tenth',      'eleventh',
        'twelfth',   'thirteenth',  'fourteenth', 'fifteenth',
        'sixteenth', 'seventeenth', 'eighteenth', 'nineteenth'
    );
    my @thousands = ( undef, 'thousand', 'million', 'billion' );

    # Split the string into blocks of three
    my @blocks = ();
    while ( length($n) > 3 ) {
        # Take off the last three numbers
        push @blocks, substr( $n, -3 );
        $n = substr( $n, 0, -3 );
    }

    push @blocks, $n;

    my @words = ();
    while ( my ( $count, $value ) = each @blocks ) {
        my $w = '';

        # Maybe this block has no numbers
        next if $value == 0;

        # Deal with the hundreds first
        if ( $value >= 100 ) {
            $w = $numbers[ int( $value / 100 ) ] . ' hundred';

            if ( $value % 100 == 0 ) {
                # Deal with numbers evenly divisable by 100
                if ( $count > 0 ) {
                    $w .= ' ' . $thousands[$count];
                }
                unshift @words, $w;
                next;
            }

            $w .= ' and ';
            $value = $value % 100;
        }

        # Then the tens
        if ( $value >= 20 ) {
            $w .= $tens[ int( $value / 10 ) ] . ' ';
            $value = $value % 10;

            if ($value == 0 and $count == 0) {
                # We need to add the ordinal word here
                substr($w, -2) = 'ieth';
            }
        }

        # And then the number
        if ($value != 0) {
            $w .= $count == 0 ? $ordinal[$value] : $numbers[$value];
        }

        # And maybe the thousandth word
        if ( $count > 0 ) {
            $w .= ' ' . $thousands[$count];
        }

        unshift @words, $w;
    }

# Edge case, if the number is evenly divisible by 100, add 'th' to the last value
    if ($hundred) {
        $words[-1] .= 'th';
    }

    # Print the ordinal number
    say join ' ', @words;
}

main( $ARGV[0] );