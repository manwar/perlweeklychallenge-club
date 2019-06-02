#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-06-01
# Week: 010
# Challenge: #1
#
#  Write a script to encode/decode Roman numerals. For example, given Roman
#  numeral CCXLVI, it should return 246. Similarly, for decimal number 39,
#  it should return XXXIX. Checkout wikipedia page for more informaiton.
#  https://en.wikipedia.org/wiki/Roman_numerals

use strict;
use warnings;
use feature qw / say /;
use Test::More tests => 10;
use Test::Exception;

my @symbols           = qw/ I V X L C D M /;
my @values            = qw/ 1 5 10 50 100 500 1000 /;
my @additive_forms    = qw/ DCCCC CCCC LXXXX XXXX VIIII IIII /;
my @subtractive_forms = qw/ CM CD XC XL IX IV /;

ok( encode_roman(246) eq "CCXLVI",     "encode 246 to CCXLVI" );
ok( encode_roman(39) eq "XXXIX",       "encode 39 to XXXIX" );
ok( decode_roman("CCXLVI") == 246,     "decode CCXLVI to 246" );
ok( decode_roman("XXXIX") == 39,       "decode XXXIX to 39" );
ok( encode_roman(3999) eq "MMMCMXCIX", "encode largest number" );
ok( decode_roman("MMMCMXCIX") == 3999, "decode largest number" );
ok( encode_roman(2019) eq "MMXIX",     "encode current year" );
ok( encode_roman(0) eq "nulla",        "encode zero" );
throws_ok { encode_roman(-1) } qr/Negative numbers/, "test negative number";
throws_ok { encode_roman(4000) } qr/greater than the largest number/,
    "test greater than largest number";

sub encode_roman {
    my $decimal_num = shift;
    my $roman_num;
    if ( $decimal_num > 0 && $decimal_num < 4000 ) {
        $roman_num = decimal_to_roman($decimal_num);
        $roman_num = abbreviate_roman($roman_num);
    }
    elsif ( $decimal_num == 0 ) {
        $roman_num = "nulla";
    }
    elsif ( $decimal_num < 0 ) {
        die "Negative numbers could not be represented in this notation";
    }
    else {
        die
            "$decimal_num is greater than the largest number that can be represented in this notation";
    }
    return $roman_num;
}

sub decode_roman {
    my $roman_num        = shift;
    my @given_symbols    = split //, $roman_num;
    my @converted_values = change_symbols_to_values(@given_symbols);
    my $decimal_num      = calculate_decimal(@converted_values);
    return $decimal_num;
}

sub change_symbols_to_values {
    my @given_symbols    = @_;
    my @converted_values = ();
    for my $s (@given_symbols) {
        push( @converted_values,
            @values[ grep { $symbols[$_] eq $s } ( 0 .. @symbols - 1 ) ] );
    }
    return @converted_values;
}

sub calculate_decimal {
    my @converted_values = reverse(@_);
    my $sum              = $converted_values[0];
    my $length           = @converted_values;
    for ( my $i = 1; $i < $length; $i++ ) {
        if ( $converted_values[ $i - 1 ] <= $converted_values[$i] ) {
            $sum += $converted_values[$i];
        }
        else {
            $sum -= $converted_values[$i];
        }
    }
    return $sum;
}

sub decimal_to_roman {
    my $decimal  = shift;
    my $roman    = "";
    my $position = scalar @values;
    while ( $decimal != 0 ) {
        if ( ( $decimal - $values[ $position - 1 ] ) >= 0 ) {
            $roman .= $symbols[ $position - 1 ];
            $decimal -= $values[ $position - 1 ];
        }
        else {
            $position--;
        }
    }
    return $roman;
}

sub abbreviate_roman {
    my $roman = shift;
    for my $int ( 0 .. ( scalar @subtractive_forms - 1 ) ) {
        $roman =~ s/$additive_forms[$int]/$subtractive_forms[$int]/;
    }
    return $roman;
}
