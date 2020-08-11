#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;

sub validate {
    my $vin = shift;
    return 0 if $vin =~ /[OIQ]/;
    return 0 unless $vin =~ /^[A-Z0-9]{17}$/;
    return check_digit($vin);
}

sub check_digit {
    my $vin = shift;
    my %translations = (
     A => 1, B => 2, C => 3, D => 4, E => 5, F => 6, G => 7, H => 8,
     J => 1, K => 2, L => 3, M => 4, N => 5, P => 7, R => 9, S => 2,
     T => 3, U => 4, V => 5, W => 6, X => 7, Y => 8, Z => 9,
    );
    $translations{$_} = $_ for 0..9;

    my @weights =
        (8, 7, 6, 5, 4, 3, 2, 10, 0, 9, 8, 7, 6, 5, 4, 3, 2);
    my $i = 0;
    my $sum = 0;
    for my $char (split //, $vin) {
        $sum += $translations{$char} * $weights[$i++];
    }
    my $mod = $sum % 11;
    $mod = 'X' if $mod == 10;
    return 1 if $mod eq substr $vin, 8, 1;
    return 0;
}

my $vin = shift // "1M8GDM9AXKP042788";
say validate($vin) ? "Correct" : "Wrong";
