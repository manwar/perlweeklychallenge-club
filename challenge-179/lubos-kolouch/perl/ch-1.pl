#!/usr/bin/perl
use strict;
use warnings;

my @units = (
    '',      'first',   'second', 'third', 'fourth', 'fifth',
    'sixth', 'seventh', 'eighth', 'ninth'
);
my @tens = (
    '',      '',        'twenty', 'thirty', 'forty', 'fifty',
    'sixty', 'seventy', 'eighty', 'ninety'
);
my @teens = (
    'tenth',      'eleventh',  'twelfth',   'thirteenth',
    'fourteenth', 'fifteenth', 'sixteenth', 'seventeenth',
    'eighteenth', 'nineteenth'
);

sub ordinal {
    my $n = shift;
    return 'tenth'           if $n == 10;
    return $teens[ $n - 10 ] if $n > 10 && $n < 20;
    return $units[$n]        if $n < 10;
    return $tens[ int( $n / 10 ) ]
      . ( $n % 10 ? '-' . $units[ $n % 10 ] : 'ieth' );
}

print ordinal( $ARGV[0] );
