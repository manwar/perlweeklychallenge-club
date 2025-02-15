#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 308 Task 2: Decode XOR
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub decode_xor_1( $encoded, $initial ) {
    my @orig;
    $orig[0] = $initial;
    $orig[ $_ + 1 ] = $orig[$_] ^ $encoded->[$_]
        for keys $encoded->@*;
    return @orig;
}

use List::Util qw( reductions );

sub decode_xor( $encoded, $initial ) {
    return reductions { $a ^ $b } $initial, $encoded->@*;
}

use Test2::V0 qw( -no_srand );
use Data::Dump qw( pp );

#
#   Flexible testing.
#

my $sub_name = "decode_xor";
my @tests = (
    [ "Example 1:", [ [1, 2, 3], 1 ], [1, 0, 2, 1] ],
    [ "Example 2:", [ [6, 2, 7, 3], 4 ], [4, 2, 0, 7, 4] ],
);

# This runs the tests not only for the sub named "$sub_name",
# but also for all variants with any suffix ("$subname<suffix>").
for my $sub ( sort grep /^${sub_name}/, keys %:: ) {
    note "\n", "Testing $sub:\n", "\n";
    for ( @tests ) {
        my ( $descr, $input, $output ) = $_->@*;
        $descr .= " $sub" . pp( $input->@* ) . " == "
	    . pp $output->@*
            if substr( $descr, -1, 1 ) eq ":";
        no strict 'refs';
	is [ $sub->( $input->@* ) ], $output, $descr;
    }
}

done_testing;
