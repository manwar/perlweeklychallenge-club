#!/usr/bin/env perl

# Challenge 178
#
# Task 1: Quater-imaginary Base
# Submitted by: Mohammad S Anwar
#
# Write a script to convert a given number (base 10) to quater-imaginary base
# number and vice-versa. For more informations, please checkout wiki page.
#
# For example,
#
# $number_base_10 = 4
# $number_quater_imaginary_base = 10300

use Modern::Perl;

sub dec_to_base2i {
    my($n) = @_;
    my $base = -4;
    my $result = "";
    while ($n != 0) {
        my $i = $n % $base;
        $n /= $base;
        if ($i < 0) {
            $i += abs($base);
            $n++;
        }
        $result = "0".$i.$result;       # imaginary is zero
    }
    $result =~ s/^0+//;
    return $result;
}

sub base2i_to_dec {
    my($n2i) = @_;
    my $base = -4;
    my $result = 0;
    my @digits = reverse split //, $n2i;
    for my $i (0..$#digits) {
        if ($i % 2 == 0) {          # real part
            $result += $digits[$i] * $base ** ($i/2);
        }
        elsif ($digits[$i] != 0) {  # imaginary part
            die "number $n2i has imaginary component";
        }
    }
    return $result;
}

dec_to_base2i(4) == 10300 or die;
base2i_to_dec(10300) == 4 or die;
