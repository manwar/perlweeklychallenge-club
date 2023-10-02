#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use List::Util qw/all/;

sub count_special_integers {
    my ($n) = @_;
    my $count = 0;

    # Iterate through 1 to $n and check if each number has unique digits
    for my $i ( 1 .. $n ) {
        my %digits_seen;
        $digits_seen{$_}++ for split //, $i;

        # If all digits are unique, the number is special
        $count++ if all { $_ == 1 } values %digits_seen;
    }

    return $count;
}

# Test Cases
is( count_special_integers(15), 14, 'Count of special integers up to 15' );
is( count_special_integers(35), 32, 'Count of special integers up to 35' );

done_testing();
