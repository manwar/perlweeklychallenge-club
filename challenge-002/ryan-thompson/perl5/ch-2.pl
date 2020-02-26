#!/usr/bin/env perl
#
# ch-2.pl - Convert integers to and from base35
#
# 2019 Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
no warnings 'uninitialized';

my @base35 = (0..9, 'a'..'y'); # Display representation
my %val; @val{@base35} = 0..34;

# Verification: Covert 20 random numbers to and from base35
printf "%8d => %8s => %8d\n", 
    $_, int_to_base35($_), base35_to_int(int_to_base35($_)) 
        for map { int rand(1e8) } 1..20;

sub int_to_base35 {
    my $int = shift;
    die "Expecting integer" unless $int =~ /^\d+$/;

    my $base35;
    while ($int) {
        $base35 = $base35[ $int % 35 ] . $base35;
        my $digit = $int % 35;
        $int = int($int / 35);
    }

    $base35 // 0;
}

sub base35_to_int {
    my $base35 = lc( shift );
    die "Expecting [0-9a-y]" unless $base35 =~ /^[0-9a-y]+$/;

    my $mul = 1; # Digits multiplier
    my $int = 0; # Result
    for (reverse split '', $base35) {
        $int += $mul * $val{$_};
        $mul *= 35;
    }

    $int;
}
