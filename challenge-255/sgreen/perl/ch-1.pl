#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub frequency_count ($s) {
    # Counts the frequency of each letter

    my %freq = ();

    foreach my $c ( split //, $s ) {
        $freq{$c}++;
    }

    return \%freq;
}

sub main ( $s, $t ) {
    # Finds extra character in second string

    my $first_freq  = frequency_count($s);
    my $second_freq = frequency_count($t);

    foreach my $c ( keys %$second_freq ) {
        if ( $second_freq->{$c} > ( $first_freq->{$c} // 0 ) ) {
            # We have found the extra character
            say $c;
            return;
        }
    }

    return 'No extra characters!';
}

main(@ARGV);