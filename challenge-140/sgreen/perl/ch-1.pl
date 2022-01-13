#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

package BinaryDecimal;
use overload '+' => '_add';

sub new {
    my ( $class, $value ) = @_;

    # Check we were supplied with a binary string
    if ( $value !~ /^[01]+$/ ) {
        die "The value $value is not binary\n";
    }
    my $self = { value => $value };
    bless $self, $class;
    return $self;
}

sub _add {
    my ( $self, $other ) = @_;
    my $value1 = $self->{value};
    my $value2 = $other->{value};
    my $result = 0;
    my $power  = 0;
    my $carry  = 0;

    while ( $carry or $value1 or $value2 ) {
        my $digit = $value1 % 10 + $value2 % 10 + $carry;
        if ( $digit >= 2 ) {
            $carry = 1;
            $digit -= 2;
        }
        else {
            $carry = 0;
        }

        $result += 10**$power
          if $digit == 1;

        $value1 = int( $value1 / 10 );
        $value2 = int( $value2 / 10 );
        $power++;
    }

    return $result;
}

package main;

sub main {
    my $value1 = BinaryDecimal->new(shift);
    my $value2 = BinaryDecimal->new(shift);
    say $value1 + $value2;
}

main(@ARGV);

