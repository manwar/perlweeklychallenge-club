#!/usr/bin/perl

use strict;
use warnings;
use List::Util qw(sum);

use Test::Deep;
use Test::More;

is_deeply(
    average_of_stream(10, 20, 30, 40, 50, 60, 70, 80, 90),
    [ 10, 15, 20, 25, 30, 35, 40, 45, 50 ]
);

done_testing;

sub average_of_stream {
    my @numbers = @_;

    my @average = ();
    my @stream  = ();
    foreach my $n (@numbers) {
        push @stream, $n;
        push @average, sum(@stream)/scalar(@stream);
    }

    return \@average;
}
