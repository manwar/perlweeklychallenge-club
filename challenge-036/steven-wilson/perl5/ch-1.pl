#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-11-25
# Week: 036
# Task #1
# Write a program to validate given Vehicle Identification Number (VIN).
# For more information, please checkout wikipedia.
# https://en.wikipedia.org/wiki/Vehicle_identification_number

use strict;
use warnings;
use feature qw/ say /;
use List::MoreUtils qw/ first_index /;
use Test::More tests => 16;

my @valid_digits
    = qw/ A B C D E F G H J K L M N P R S T V W X Y Z 0 1 2 3 4 5 6 7 8 9 /;
my %valid_digits = map { $_ => 1 } @valid_digits;
my @year_code
    = qw/ A B C D E F G H J K L M N P R S T V W X Y 1 2 3 4 5 6 7 8 9
    A B C D E F G H J K L M N P R S T V W X Y 1 2 3 4 5 6 7 8 9 /;
my %year_code       = map { $_ => 1 } @year_code;
my @year            = 1980 .. 2039;
my @weight_factor   = qw/ 8 7 6 5 4 3 2 10 0 9 8 7 6 5 4 3 2 /;
my %transliteration = qw/ A 1 B 2 C 3 D 4 E 5 F 6 G 7 H 8 J 1 K 2 L 3 M 4 N 5
    P 7 R 9 S 2 T 3 U 4 V 5 W 6 X 7 Y 8 Z 9 /;
my %wmi_codes;
my $wmi_file = 'wmi_common_codes';

open my $fh, '<', $wmi_file or die "Can't open < $wmi_file: $!";
while ( my $row = <$fh> ) {
    chomp $row;
    $row =~ /^([[:alnum:]]+)\s(.*)/;
    my $wmi_code = $1;
    my $wmi_man  = $2;
    $wmi_man =~ s/^\s+|\s+$//g;
    $wmi_man =~ s/\s+/ /g;
    $wmi_codes{$wmi_code} = $wmi_man;
}

# for (sort keys %wmi_codes){
#     say "$_:\t$wmi_codes{$_}";
# }

ok( is_valid("1HGCM82633A004352") == 1,          "test valid VIN" );
ok( is_valid("1HGCM82633A0043529") == 0,         "18 digits is invalid" );
ok( is_valid("1HGCM82633A0O4352") == 0,          "invalid digit" );
ok( is_valid("1HGCM8263ZA004352") == 0,          "invalid digit 10" );
ok( is_valid("2FTPX28L0XCA15511") == 1,          "valid Canadian VIN" );
ok( is_valid("2FTPX28L1XCA15511") == 0,          "invalid Canadian VIN" );
ok( is_valid("ZFFTA17B000053081") == 1,          "valid European VIN" );
ok( get_model_year("1HGCM82633A004352") == 2003, "yr when digit 7 numeric" );
ok( get_model_year("1HGCM8C633A004352") == 2023, "yr when digit 7 alphabetic" );
ok( get_model_year("1HGCM82630A004352") == 1980, "yr when digit 10 0" );
ok( get_model_year("1HGCM8263CA004352") == 1982, "yr when digit 10 alphabetic" );
ok( get_check_digit("1M8GDM9AXKP042788") eq 'X', "check digit is X" );
ok( get_check_digit("5GZCZ43D13S812715") eq '1', "check digit is numeric" );
ok( get_check_digit("11111111111111111") eq '1', "check digit 17 x '1' is 1" );
ok( get_wmi_details("ZFFTA17B000053081") eq "ZFF",    "check wmi present" );
ok( !defined( get_wmi_details("ZZZTA17B000053081") ), "check wmi undef" );

my @vins = qw/ 1HGCM82633A004352 ZFFTA17B000053081 2FTPX28L0XCA15511
    1M8GDM9AXKP042788 2FTPX28L1XCA15511/;

for my $vin (@vins) {
    my %vin_details;
    my $is_valid = 0;
    my ( $wmi, $vds, $vis ) = (
        ( substr $vin, 0, 3 ),
        ( substr $vin, 3, 6 ),
        ( substr $vin, 9, 8 )
    );
    say "\nVIN: $vin";
    say "WMI: $wmi";
    say "VDS: $vds";
    say "VIS: $vis";
    say "10 : ", substr $vin, 9, 1;
    say "7  : ", substr $vin, 6, 1;

    if ( is_valid($vin) ) {
        $vin_details{"year"} = get_model_year($vin);
        my $wmi = get_wmi_details($vin);
        $vin_details{"wmi"} = $wmi_codes{$wmi} if defined $wmi;
    }
    else {
        say "$vin is not a valid VIN.";
    }

    for ( keys %vin_details ) {
        say "$_: $vin_details{$_}";
    }
}

sub is_valid {
    my $vin = shift;

    # length equals 17 digits
    if ( length $vin != 17 ) {
        return 0;
    }

    # digits are all valid
    if ( grep { !exists $valid_digits{$_} } split //, $vin ) {
        return 0;
    }

    #check USA and Canada VIN
    if ( ( substr $vin, 0, 1 ) =~ /[1|2|4|5]/ ) {

        # all position 10 digits are valid
        if ( !exists $year_code{ substr $vin, 9, 1 } ) {
            return 0;
        }

        # check digit valid
        my $check = substr $vin, 8, 1;
        if ( $check ne get_check_digit($vin) ) {
            return 0;
        }
    }

    return 1;
}

sub get_model_year {
    my $vin = shift;
    my $digit_ten = substr $vin, 9, 1;
    my $index
        = $digit_ten eq 0 ? 0 : first_index { $_ eq $digit_ten } @year_code;
    if ( $vin =~ /^[[:alnum:]]{6}[[:alpha:]]{1}/ && $digit_ten ne 0 ) {
        $index += 20;
    }
    return $year[$index];
}

sub get_check_digit {
    my $vin = shift;
    my @values = map { $_ =~ /\d/ ? $_ : $transliteration{$_} } split //,
        $vin;
    my $sum_products;
    for ( my $i = 0; $i < 17; $i++ ) {
        $sum_products += $values[$i] * $weight_factor[$i];
    }
    my $remainder = $sum_products % 11;
    $remainder == 10 ? return 'X' : return $remainder;
}

sub get_wmi_details {
    my $vin = shift;
    my $wmi = undef;
    for ( sort keys %wmi_codes ) {
        if ( ( substr $vin, 0, ( length $_ ) ) eq $_ ) {
            $wmi = $_;
        }
    }
    return $wmi;
}
