#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ postderef say signatures state };
no warnings qw{ experimental };

use Carp;

my $i = shift @ARGV;
$i //= 2;
croak 'non-positive integer' if $i < 1;
croak 'not an integer'       if $i =~ /\D/;

say join "\n\t", "RARE NUMBERS: $i", rare_numbers($i), '';

# a number r is "rare" when:
#   - r1 is that number reversed
#   - sqrt(r+r1) is an integer
#   - sqrt(r-r1) is an integer
sub rare_numbers ( $i ) {
    my @output;

    # given i == 5,
    # low is 10000, the smallest five-digit number
    # high is 99999, the highest five-digit number
    my $low  = join '', map { $_ == 1 ? 1 : 0 } 1 .. $i;
    my $high = 9 x $i;

    for my $r ( $low .. $high ) {
        my $r1 = reverse $r;
        next if $r - $r1 < 0;    # early block for thing that break sqrt

        my $s1 = sqrt( $r + $r1 );
        next if $s1 =~ /\D/;     # test if integer

        my $s2 = sqrt( $r - $r1 );
        next if $s2 =~ /\D/;     # test if integer


        push @output, $r;
    }
    return @output;
}
