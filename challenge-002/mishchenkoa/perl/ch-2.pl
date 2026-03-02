#!/usr/bin/perl
use warnings;

# References
# 1. https://www.unitconverters.net/numbers/base-35-to-decimal.htm - used to manually test
# the conversion.
# 2. https://condor.depaul.edu/psisul/conversionmath.html - refresher on how to convert between 
# different number bases.


my %FROM_BASE_35 = (
    0 => 0,
    1 => 1,
    2 => 2,
    3 => 3,
    4 => 4,
    5 => 5,
    6 => 6,
    7 => 7,
    8 => 8,
    9 => 9,
    A => 10,
    B => 11,
    C => 12,
    D => 13,
    E => 14,
    F => 15,
    G => 16,
    H => 17,
    I => 18,
    J => 19,
    K => 20,
    L => 21,
    M => 22,
    N => 23,
    O => 24,
    P => 25,
    Q => 26,
    R => 27,
    S => 28,
    T => 29,
    U => 30,
    V => 31,
    W => 32,
    X => 33,
    Y => 34
);

my %TO_BASE_35;

foreach my $base_35 (keys %FROM_BASE_35){
    $TO_BASE_35{$FROM_BASE_35{$base_35}} = $base_35;
}

sub to_base_35{
    my $val = shift;

    # Validate numeric input (integer only)
    return unless defined $val && $val =~ /^-?\d+$/;

    my $is_negative = ($val < 0) ? 1 : 0;
    my $normalized_val = abs(int($val));

    # Explicit zero handling
    return "0" if $normalized_val == 0;

    # Direct conversion
    if ($normalized_val < 35){
        my $result = $TO_BASE_35{$normalized_val};
        return $is_negative ? "-$result" : $result;
    }

    my $sentinel = -1;
    my @remainders;

    while ($sentinel != 0){
        my $remainder = $normalized_val % 35;
        push(@remainders, $remainder);

        $normalized_val = ($normalized_val - $remainder) / 35;

        if ($normalized_val < 35){
            push(@remainders, $normalized_val);
            $sentinel = 0;
        }
    }

    my $base_35_number = "";
    while (@remainders) {
        $base_35_number .= $TO_BASE_35{pop @remainders};
    }

    return $is_negative ? "-$base_35_number" : $base_35_number;
}

sub from_base_35{
    my $val = shift;

    return unless defined $val && $val ne "";

    my $is_negative = 0;

    if ($val =~ s/^-//) {
        $is_negative = 1;
    }

    # Validate full string contains only valid base-35 chars
    return unless $val =~ /^[0-9A-Ya-y]+$/;

    my $decimal_result = 0;
    my $val_len = length($val) - 1;

    foreach my $base_35_char (split //, $val){
        my $decimal_var = $FROM_BASE_35{uc($base_35_char)};
        return unless defined $decimal_var;  # extra safety

        $decimal_result += $decimal_var * 35**$val_len;
        $val_len -= 1;
    }

    return $is_negative ? -$decimal_result : $decimal_result;
}

print("Base 35 number -> ", to_base_35(109093333), "\n");
print("Base 10 number -> ", from_base_35("22OFRD"), "\n");