#!/usr/bin/env perl
# Week 135 Task 2
# Validate SEDOL

use strict;
use warnings;
use feature qw/ say /;
use Test::More;
use Test::Exception;

ok( validate_sedol('2936921') == 1, "Valid SEDOL" );
ok( validate_sedol('1234567') == 0, "Invalid SEDOL" );
ok( validate_sedol('B0YBKL9') == 1, "Valid SEDOL" );
dies_ok { validate_sedol('B0YBKLA'), } 'Die when check digit not a digit';
dies_ok { validate_sedol('B0YBKLF9'), } "Die when SEDOL not correct length";
dies_ok { validate_sedol('#0YDK29'), } "Die when invalid character";
done_testing();

sub validate_sedol {
    my $input = shift;
    length $input == 7 or die "Invalid SEDOL number, not correct length\n";
    my $code  = substr $input, 0, 6;
    my $check = substr $input, 6, 1;
    $check =~ /[0-9]/ or die "Invalid SEDOL number, invalid check digit\n";
    $check == get_sedol_check_digit($code);
}

sub get_sedol_check_digit {
    my $code   = shift;
    my @weight = qw/ 1 3 1 7 3 9 1 /;
    $code =~ /[0-9A-Z]{6}/ or die "Invalid SEDOL number, invalid character\n";
    my @code = split //, $code;
    my $sum  = 0;
    for ( my $i = 0; $i < 6; $i++ ) {
        if ( ord( $code[$i] ) < 58 ) {
            $sum += ( $code[$i] * $weight[$i] );
        }
        else {
            $sum += ( ( ord( $code[$i] ) - 64 + 9 ) * $weight[$i] );
        }
    }
    return ( ( 10 - ( $sum % 10 ) ) % 10 );
}
