#!/usr/bin/perl
use strict;
use warnings;
use POSIX;

sub check {
    my ( $numerator, $denominator ) = @_;

    ( $numerator + $denominator == $numerator ) && ( $denominator == floor $denominator ) && die 'divide by zero error';
}
