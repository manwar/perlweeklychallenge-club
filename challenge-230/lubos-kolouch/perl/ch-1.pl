#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use Data::Dumper;

sub separate_digits {
    my (@ints) = @_;

    my @digits;
    for my $num (@ints) {
        my @digit_array = split //, $num;
        push @digits, @digit_array;
    }

    return \@digits;
}

my @ints     = ( 1, 34, 5, 6 );
my @expected = ( 1, 3,  4, 5, 6 );

is_deeply( separate_digits(@ints), \@expected, 'Example 1' );

@ints     = ( 1, 24, 51, 60 );
@expected = ( 1, 2,  4,  5, 1, 6, 0 );
is_deeply( separate_digits(@ints), \@expected, 'Example 2' );

done_testing();
