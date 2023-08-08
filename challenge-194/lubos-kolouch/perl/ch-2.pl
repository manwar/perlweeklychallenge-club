#!/usr/bin/perl

use strict;
use warnings;
use Test::More;

sub frequency_equalizer {
    my ($s) = @_;
    my %frequency;

    # Count the frequency of each character in the string
    $frequency{$_}++ for split //, $s;

    # Create a frequency histogram to track the count of each frequency
    my %frequency_histogram;
    $frequency_histogram{$_}++ for values %frequency;

    # Check if there's only one frequency, and that removing one occurrence will not equalize frequencies
    return 0 if keys %frequency_histogram == 1 && ( values %frequency_histogram )[0] == 1;

    # Check if there is one frequency that appears only once and the rest are the same
    if ( grep { $frequency_histogram{$_} == 1 } keys %frequency_histogram ) {
        my @unique_freq = grep { $frequency_histogram{$_} == 1 } keys %frequency_histogram;
        delete $frequency_histogram{ $unique_freq[0] };
        return 1
          if keys %frequency_histogram == 1
          && ( $unique_freq[0] == 1 || $unique_freq[0] - 1 == ( keys %frequency_histogram )[0] );
    }

    return 0;
}

is( frequency_equalizer('abbc'),    1, 'One character with frequency one more than others' );
is( frequency_equalizer('xyzyyxz'), 1, 'One character with frequency one more than others, mixed' );
is( frequency_equalizer('xzxz'),    0, 'All characters with equal frequency' );

done_testing();
