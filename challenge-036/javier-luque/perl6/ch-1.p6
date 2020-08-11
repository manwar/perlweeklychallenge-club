# Test: perl6 ch-1.p6
use v6.d;

sub MAIN() {
    # Check a bunch of different world VIN's
    # These should be valid
    for ( 'SCFFDAAM4EGA15321', 'JTHBA30G355101885',
          '1D7HA18P57J602071', 'WA1LFAFP7EA118600',
          '1NXBU40E39Z155675', '3VWSK69MX5M058145',
          'JS3TY92V534101150', 'WDDHF5KBXEA837164') -> $vin {
        check-vin($vin.uc);
    }

    # These should be invalid
    for ( 'SCFFDAAM4EGA1$321', 'JTHBA30G3Z5101885',
          '1D7HA18P57J602072', '1NXBU40E79Z15567x') -> $vin {
        check-vin($vin.uc);
    }
}

# Check vin
sub check-vin(Str $vin) {
    if (_check-vin($vin)) {
        say "$vin is valid.";
    } else {
        say "$vin is not valid.";
    };
}

# Check vin (the guts)
sub _check-vin(Str $vin) {
    my $vin_re = /<[A..HJ..NPR..Z0..9]>/;

    # Check for valid World Vin
    return Nil unless ($vin ~~ /
        ^^              # Start of string
        ($vin_re ** 3)  # World identification number
        ($vin_re ** 6)  # Vehicle descriptor section
        ($vin_re ** 8)  # Vehicle identifier section
        $$              # End of string
    /);

    # Capture parts of the vin
    my $win = $0; # World identification number
    my $vds = $1; # Vehicle descriptor section
    my $vis = $2; # Vehicle identifier section

    # 1st digit of the VIS can't be a U, Z or 0
    return Nil if ($vis ~~ /^^<[UZ0]>/);

    # Need to validate check digit
    # compulsory for vehicles
    # in North America and China,
    if ($win ~~ /^^<[1..5L]>/) {
        return Nil unless check-digit($vin);
    }

    # In america and china the last 5
    # digits of the vis is numeric
    if ($win ~~  /^^<[1..5L]>/) {
        return Nil unless ($vis ~~ /
            ^^             # Start of string
            $vin_re ** 3   # First 3
            \d  ** 5       # Last 5 digits
            $$             # End of string
        /);
    }

    return 1;
}

# Calculate the check digit
sub check-digit(Str $vin) {
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
        Y => 8, Z => 9 );

    # Weights
    my @weights = (
      8,7,6,5,4,3,2,10,0,
      9,8,7,6,5,4,3,2
    );

    # Calculate the check digit
    my $x = 0;
    my @chars = $vin.comb;

    for (0 .. @chars.end) -> $i {
        my $val = %translate{@chars[$i]} ??
            %translate{@chars[$i]} !! @chars[$i];
            $products += $val * @weights[$i];
    }

    # Calculate the check digit
    my $mod = ($products % 11).Str;
    $mod = 'X' if $mod == 10;

    # Check the digit
    my $check_digit = substr $vin, 8, 1;
    return $mod eq $check_digit;
}
