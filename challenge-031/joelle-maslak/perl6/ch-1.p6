#!/usr/bin/env perl6
use v6;

#
# Copyright © 2019 Joelle Maslak
# All Rights Reserved - See License
#

sub MAIN($numerator, $denominator) {
    if test-for-div-by-zero($numerator, $denominator) {
        say "Denominator is zero";
    } else {
        say "Denominator is not zero";
    }
}

sub test-for-div-by-zero($numerator, $denominator) {
    ($numerator / $denominator).Int.sink;

    return; # Not div by zero

    CATCH {
        when X::Numeric::DivideByZero {
            return 1; # Div by zero
        }
    }
}

