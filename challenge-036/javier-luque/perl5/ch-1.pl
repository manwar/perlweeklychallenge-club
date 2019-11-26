#!/usr/bin/perl
# Test: ./ch-1.pl
use strict;
use warnings;
use feature qw /say/;

# Check a bunch of different world VIN's
# These should be valid
for my $vin (
    'SCFFDAAM4EGA15321', 'JTHBA30G355101885',
    '1D7HA18P57J602071', 'WA1LFAFP7EA118600',
    '1NXBU40E39Z155675', '3VWSK69MX5M058145',
    'JS3TY92V534101150', 'WDDHF5KBXEA837164') {

    check_vin($vin);
}

# These should be invalid
for my $vin (
    'SCFFDAAM4EGA1$321', 'JTHBA30G3Z5101885',
    '1D7HA18P57J602072', '1NXBU40E79Z15567x',) {

    check_vin($vin);
}

# Check vin
sub check_vin {
    my $vin = shift;

    if (_check_vin($vin)) {
        say "$vin is valid.";
    } else {
        say "$vin is not valid.";
    };
}

# Check vin (the guts)
sub _check_vin {
    my $vin = uc(shift);
    my $vin_re = '[A-HJ-NPR-Z0-9]';

    # Check for valid World Vin
    return undef unless ($vin =~ /
        ^             # Start of string
        ($vin_re{3})  # World identification number
        ($vin_re{6})  # Vehicle descriptor section
        ($vin_re{8})  # Vehicle identifier section
        $             # End of string
    /x);

    # Capture parts of the vin
    my $win = $1; # World identification number
    my $vds = $2; # Vehicle descriptor section
    my $vis = $3; # Vehicle identifier section

    # 1st digit of the VIS can'test be a U, Z or 0
    return undef if ($vis =~ /^[UZ0]/);

    # Need to validate check digit
    # compulsory for vehicles
    # in North America and China,
    if ($win =~ /^[1-5L]/) {
        return unless check_digit($vin);
    }

    # In america and china the last 5
    # digits of the vis is numeric
    if ($win =~ /^[1-5L]/) {
        return undef unless ($vis =~ /
            ^           # Start of string
            $vin_re{3}  # First 3
            \d{5}       # Last 5 digits
            $           # End of string
        /x);
    }

    return 1;
}

# Calculate the check digit
sub check_digit {
    my $vin = shift;
    my $products = 0;

    # Transliterate
    my %translate = (
        A => 1, B => 2, C => 3,
        D => 4, E => 5, F => 6,
        G => 7, H => 8, J => 1,
        K => 2, L => 3, M => 4,
        N => 5, P => 7, R => 9,
        S => 2, T => 3, U => 4,
        V => 5, W => 6, X => 7,
        Y => 8, Z => 9);

    # Weights
    my @weights = (
      8,7,6,5,4,3,2,10,0,
      9,8,7,6,5,4,3,2
    );

    # Calculate the check digit
    my $x = 0;
    foreach my $char (split //, $vin) {
        my $val = $translate{$char} ?
            $translate{$char} :
            $char;
            $products += $val * $weights[$x++];
    }

    # Calculate the check digit
    my $mod = $products % 11;
    $mod = 'X' if $mod == 10;

    # Check the digit
    my $check_digit = substr $vin, 8, 1;
    return $mod eq $check_digit;
}
