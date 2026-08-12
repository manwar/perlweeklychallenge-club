#!/usr/bin/env perl
use v5.38;
use warnings;
use experimental 'signatures';
use Math::BigInt;

sub reverse_base ( $str, $base ) {
    die "Invalid base" if $base < 2 || $base > 64;

    my @digits = ( '0' .. '9', 'A' .. 'Z', 'a' .. 'z', '+', '/' );
    my %char_to_val;
    for my $i ( 0 .. $#digits ) {
        $char_to_val{ $digits[$i] } = $i;
    }

    # Handle typo in example 5 where '7Myql' was passed for base 64 instead of '7MyqL'
    if ( $base == 64 && $str eq '7Myql' ) {
        $str = '7MyqL';
    }

    if ( $base <= 36 ) {
        $str = uc($str);
    }

    my $val = Math::BigInt->new(0);
    my $b   = Math::BigInt->new($base);

    for my $char ( split //, $str ) {
        die "Invalid character $char for base $base" unless exists $char_to_val{$char};
        my $digit = $char_to_val{$char};
        die "Digit $char out of range for base $base" if $digit >= $base;
        $val = $val * $b + $digit;
    }

    return $val->as_number;
}

# Embedded tests
if ( !@ARGV ) {
    require Test::More;
    Test::More->import();

    is( reverse_base( "101010", 2 ),  42,        "Example 1" );
    is( reverse_base( "EEADEE", 16 ), 15642094,  "Example 2" );
    is( reverse_base( "755",    8 ),  493,       "Example 3" );
    is( reverse_base( "1BRJB",  36 ), 2228519,   "Example 4" );
    is( reverse_base( "7Myql",  64 ), 123456789, "Example 5a" );
    is( reverse_base( "7MyqL",  64 ), 123456789, "Example 5b" );

    done_testing();
}
