use strict;
use warnings;

use v5.38;

sub check_numberable( $str ) {
    # iteratively remove trailing 'exponent' strings
    while ( $str =~ s/(e|E)(\+|-)?\d+$// ) {}
    
    return $str =~ /^(\+|-)?(\d+|(\d+\.\d*|\d*\.\d+))$/;
}

my @inputs = (
    '',
    'E-250',
    '1',
    'a',
    '.',
    '1.2e4.2',
    '-1.',
    '+1E-8',
    '.44',
    '1E-8e100E1000e100e-10e+1000',
    '1E-8e100E1000e100.1e-10e+1000',
    );
for my $input (@inputs) {
    say $input . ' => ' . ( check_numberable( $input ) ? 'true' : 'false' );
}
    
