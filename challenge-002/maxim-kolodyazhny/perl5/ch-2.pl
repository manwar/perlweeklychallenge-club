#!/usr/bin/env perl

use strict;
use warnings;

use v5.28.0;
use feature 'signatures';
no warnings 'experimental::signatures';

use Getopt::Long;
use Pod::Usage;

use constant {
    BASE_FOR_BASE35  => 35,
    EXIT_STATUS_OK   => 0,
};

# Omitting declaration outside the map block with dirty but
# interesting *I hope* hack with state and postfix increment
my %map_from_dec =  map { state $map_counter++ => $_ } ( 0..9, 'a'..'y' );

pod2usage( EXIT_STATUS_OK ) unless @ARGV;

my @results = ();

GetOptions(
    'dec-to-base35=i' => \&dec_to_base35,
    'base35-to-dec=s' => \&base35_to_dec,
);

sub dec_to_base35 ( $opt_name, $decimal_value ) {

    my $base35_number   = '';
    my $quotient        = $decimal_value;

    while ( $quotient >= BASE_FOR_BASE35 ) {

        my $reminder   = $quotient % BASE_FOR_BASE35;
        $quotient      = int $quotient / BASE_FOR_BASE35;
        $base35_number = $map_from_dec{ $reminder } . $base35_number;
    }

    $base35_number = $map_from_dec{ $quotient } . $base35_number;
    push @results, $base35_number;

    return;
}

sub base35_to_dec ( $opt_name, $base35_value  ) {

    # 1. state variables will be initialized only once
    # 2. reverse will swap keys and values
    state %map_from_base35 = reverse %map_from_dec;

    my ( $pow_counter, $decimal_number ) = (0) x 2;

    foreach my $char ( reverse split //, $base35_value ) {

        my $numeric_value = $map_from_base35{ lc $char };

        $decimal_number += $numeric_value * (BASE_FOR_BASE35 ** $pow_counter);

        $pow_counter++;
    }

    push @results, $decimal_number;

    return;
}

say join "\n", @results;

__END__
=head1 NAME

decimal to base35 converter

=head1 SYNOPSIS

./base35.pl [options]

    Options:
        --dec-to-base35            convert from decimal to base35
        --base35-to-dec            convert from base35 to decimal

    Example:
        ./base35.pl --dec-to-base35 10

Thanks to Getopt::Long, you can abbreviate parameters!

    Example:
        ./base35.pl --d 10 --b 66y

=cut
