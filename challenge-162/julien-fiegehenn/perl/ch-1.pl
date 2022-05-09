#!/usr/bin/env perl
use strict;
use warnings;

use feature 'say';
use List::Util 'sum';

# Write a script to generate the check digit of given ISBN-13 code. Please refer wikipedia for more information.

# Example
# ISBN-13 check digit for '978-0-306-40615-7' is 7.

# https://en.wikipedia.org/wiki/ISBN#ISBN-13_check_digit_calculation

sub isbn_13 {
    my $number = shift;

    die 'Input required' unless $number;

    # clean up the number
    $number =~ s/\D//g;

    # we need to do maths on each digit
    my @digits = split //, $number;

    # discard the check digit
    pop @digits if @digits == 13;

    # do we have the right amount of digits?
    die 'This does not look like an ISBN-13' unless @digits == 12;

    # tripple all the even digits
    $_ *= 3 for @digits[1, 3, 5, 7, 9, 11];

    # and do the maths
    return 10 - sum(@digits) % 10;
}

say isbn_13(shift);

__END__
use Test::More;

is isbn_13('978-0-306-40615-7'), 7;

done_testing;