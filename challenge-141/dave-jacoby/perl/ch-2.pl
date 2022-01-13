#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures state };
no warnings qw{ experimental };

use Carp;
use Getopt::Long;

my $m = 1234;
my $n = 2;

GetOptions(
    'm=i' => \$m,
    'n=i' => \$n,
);

croak q{$m is not positive} if $m < 1;
croak q{$n is not positive} if $n < 1;

my @like_numbers = like_numbers( $m, $n );
say join ' ', @like_numbers;

sub like_numbers ( $m, $n ) {
    my @numbers = make_numbers($m);
    return

        sort { $a <=> $b }
        grep { $_ % $n == 0 }
        grep { $_ != $m }

        @numbers;
}

sub make_numbers ( $number, $n = '' ) {
    my @output;
    for my $i ( 0 .. -1 + length $number ) {
        my $x = $n . substr( $number, $i, 1 );
        my $y = substr( $number, $i + 1 );
        push @output, $x;
        push @output, make_numbers( $y, $x ) if length $y;
    }
    return @output;
}
