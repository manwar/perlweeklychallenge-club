#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'uniq';

sub main (@n) {
    # Remove non-unique values
    @n = map { int($_) } uniq @n;
    my $max = $n[0] ^ $n[1];

    # Work through each combination of two numbers
    foreach my $first ( 0 .. $#n - 1 ) {
        foreach my $second ( $first + 1 .. $#n ) {
            my $xor_value = $n[$first] ^ $n[$second];
            if ( $max < $xor_value ) {
                # We have a new maximum value
                $max = $xor_value;
            }
        }
    }

    # Print the maximum value found
    say $max;
}

main(@ARGV);