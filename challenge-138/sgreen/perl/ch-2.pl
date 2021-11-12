#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

use List::Util 'sum';

sub _can_split {
    my ( $target, $used, $pool ) = @_;

    # The first number cannot be all digits
    my $max = $#$used == -1 ? length($pool) - 1 : length($pool);

    foreach my $l ( 1 .. $max ) {
        if ( $l == length($pool) ) {
            return 1 if sum( @$used, $pool ) == $target;
        }
        else {
            # We can split the number
            my $found = _can_split( $target, [ @$used, substr( $pool, 0, $l ) ], substr( $pool, $l ) );
            return 1 if $found;
        }
    }

    return 0;
}

sub main {
    my $n = shift;

    # Sanity check
    die "You must specify a number\n"            unless defined $n;
    die "The input doesn't look like a number\n" unless $n =~ /^[1-9][0-9]*$/;

    # Check the number is a perfect square
    my $s = sqrt($n);
    die "The number isn't a perfect sqaure\n" unless $s == int($s);

    say _can_split( $s, [], $n );
}

main(@ARGV);
