#!/usr/bin/env perl
use v5.38;
use warnings;
use experimental 'signatures';
use Math::BigFloat;

# Task 2: Ramanujan's constant
# Calculate Ramanujan's constant e^(pi * sqrt(163)) with at least 32 digits of precision.

sub ramanujan_constant ($digits = 35) {
    # Set high precision with guard digits
    Math::BigFloat->accuracy( $digits + 10 );

    my $pi       = Math::BigFloat->bpi( $digits + 10 );
    my $sqrt_163 = Math::BigFloat->new(163)->bsqrt();
    my $exponent = $pi->bmul($sqrt_163);
    my $constant = $exponent->bexp();

    # Return trimmed to requested precision
    $constant->accuracy($digits);
    return $constant->bstr();
}

# Embedded tests
if ( !@ARGV ) {
    require Test::More;
    Test::More->import();

    my $res = ramanujan_constant(35);
    # Known prefix: 262537412640768743.999999999999250072
    like( $res, qr/^262537412640768743\.99999999999925/, 'Matches Ramanujan constant to 32+ digits' );

    done_testing();
}
else {
    my $prec = $ARGV[0] // 35;
    say ramanujan_constant($prec);
}
