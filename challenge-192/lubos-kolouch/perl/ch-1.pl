#!/usr/bin/perl

use strict;
use warnings;
use Test::More;

sub binary_flip {
    my ($n)    = @_;
    my $binary = sprintf "%b", $n;    # Convert to binary
    $binary =~ tr/01/10/;             # Flip the bits
    return oct("0b$binary");          # Convert back to decimal
}

is( binary_flip(5), 2, 'Example 1' );
is( binary_flip(4), 3, 'Example 2' );
is( binary_flip(6), 1, 'Example 3' );

done_testing();
