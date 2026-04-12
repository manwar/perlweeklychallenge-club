#!/usr/bin/perl
use strict;
use warnings;

# I use 'foreach', which is better for performance and clarity because
# I'm not trying to generate a new list, you're simply summing or
# multiplying values in-place.

sub round_to {
    my ($num, $places) = @_;
    my $multiplier = 10 ** $places;
    my $rounded = int($num * $multiplier + 0.5) / $multiplier;
    return sprintf("%.${places}f", $rounded);  # Force decimal format
}

sub validate_input {

    my ($aref) = @_;

    # Validate it's an array reference
    return undef unless ref($aref) eq 'ARRAY';

    my @n = @$aref;

    return 0 if (@n < 2);

    for (@n) {
        return 0 unless defined($_) && /^[+-]?\d+(\.\d+)?$/;
    }

    return 1;
}

sub arithmetic_mean {

    my ($aref) = @_;
    my $sum = 0;

    $sum += $_ foreach (@$aref);
    return round_to($sum/scalar(@$aref), 1);

}

sub geometric_mean {

    my ($aref) = @_;
    my $product = 1;

    $product *= $_ foreach (@$aref);
    return round_to($product ** (1/scalar(@$aref)), 1);
}

sub harmonic_mean {

    my ($aref) = @_;
    my $sum = 0;
    foreach (@$aref) {
        die "Oops! It looks like you have a zero in your data, which can't
             be used to calculate the harmonic mean. The program will exit now.\n" if ($_ == 0);
        $sum += 1/$_;
    }
    return round_to(scalar(@$aref)/$sum, 1);
}

sub pythagorean_means {
    my ($aref) = @_;

    if (validate_input($aref)) {

        my $am = arithmetic_mean($aref);
        my $gm = geometric_mean($aref);
        my $hm = harmonic_mean($aref);

        return ($am, $gm, $hm);
    }
    else {
        return (undef, undef, undef);
    }

}

# Tests
my (@n, @res);

# Example 1
@n = (1,3,5,6,9);
@res = pythagorean_means(\@n);
print "AM = $res[0], GM = $res[1], HM = $res[2]\n"; # Output: AM = 4.8, GM = 3.8, HM = 2.8

# Example 2
@n = (2,4,6,8,10);
@res = pythagorean_means(\@n);
print "AM = $res[0], GM = $res[1], HM = $res[2]\n"; # Output: AM = 6.0, GM = 5.2, HM = 4.4

# Example 3
@n = (1,2,3,4,5);
@res = pythagorean_means(\@n);
print "AM = $res[0], GM = $res[1], HM = $res[2]\n"; # Output: AM = 3.0, GM = 2.6, HM = 2.2
