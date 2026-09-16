#!/usr/bin/env perl
use v5.38;
use warnings;
use experimental 'signatures';

# Task 1: Vehicle Identification Numbers (VIN) Validation
# Validate a 17-character VIN using the ISO 3779 / US standard checksum rule.

sub validate_vin ($vin) {
    $vin = uc($vin);
    $vin =~ s/\s+//g;

    return 0 unless length($vin) == 17;

    # Letters I, O, Q are not allowed in VIN
    return 0 if $vin =~ /[IOQ]/;

    my %trans = (
        A => 1, B => 2, C => 3, D => 4, E => 5, F => 6, G => 7, H => 8,
        J => 1, K => 2, L => 3, M => 4, N => 5, P => 7, R => 9,
        S => 2, T => 3, U => 4, V => 5, W => 6, X => 7, Y => 8, Z => 9,
    );

    my @weights = ( 8, 7, 6, 5, 4, 3, 2, 10, 0, 9, 8, 7, 6, 5, 4, 3, 2 );

    my $sum = 0;
    my @chars = split //, $vin;

    for my $i ( 0 .. 16 ) {
        my $c = $chars[$i];
        my $val;
        if ( $c =~ /^\d$/ ) {
            $val = int($c);
        }
        elsif ( exists $trans{$c} ) {
            $val = $trans{$c};
        }
        else {
            return 0;
        }
        $sum += $val * $weights[$i];
    }

    my $remainder = $sum % 11;
    my $expected_check = ( $remainder == 10 ) ? 'X' : "$remainder";

    return ( $chars[8] eq $expected_check ) ? 1 : 0;
}

# Embedded tests
if ( !@ARGV ) {
    require Test::More;
    Test::More->import();

    is( validate_vin('11111111111111111'), 1, 'Valid VIN with check digit 1' );
    is( validate_vin('1HGCR2F83HA000000'), 0, 'Invalid VIN' );
    is( validate_vin('1FA6P8CF0H5000000'), 0, 'Invalid VIN' );
    is( validate_vin('12345'),             0, 'Invalid short VIN' );
    is( validate_vin('11111111I11111111'), 0, 'Contains prohibited letter I' );

    done_testing();
}
else {
    say validate_vin( $ARGV[0] ) ? 'valid' : 'invalid';
}
