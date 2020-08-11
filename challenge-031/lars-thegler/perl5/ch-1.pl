#!/usr/bin/env perl

use Modern::Perl;
use Try::Tiny;

# Create a function to check divide by zero error without checking
# if the denominator is zero.

say divide_by_zero_error( 4, 0 );
say divide_by_zero_error( 3, 12 );
say divide_by_zero_error( 0, 4 );

sub divide_by_zero_error
{
    my ( $numerator, $denominator ) = @_;
    my $error;
    try {
        my $ratio = $numerator / $denominator;
    } catch {
        if ($_ =~ /division by zero/) {
            $error = 'divide by zero error';
        } else {
            die $_;
        }
    };
    return $error // 'all good';
}
