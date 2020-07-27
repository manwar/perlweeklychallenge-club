#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental::signatures };

use Carp;
use Getopt::Long;
use JSON;

# base case is the example;
my $n = 2;

GetOptions( 'number=i' => \$n, );

# constraints
2 <= $n || croak 'N too small';
$n <= 5 || croak 'M too big';

say qq{n: $n};

grey_code($n);

sub grey_code ( $n ) {

    # I THINK...
    # a zero-bit grey sequence would be []
    # for one bit, add '0' to each nothing to the left,
    #   '1' to each nothing to the right,
    #    so we get the one-bit grey sequence of [ 0, 1 ]
    # for a two-bit grey sequence, we do the same, but
    #   with actual sequences, which become
    # [ 00 , 01 , 11, 10 ], which, when turned back to
    # decimal, becomes...
    my @sequence = ( 0, 1, 3, 2 );

    # conceptually, we need a while, not a do-while, because
    # the sequence, right now, is a correct two-bit grey sequence
    if ( $n > 2 ) {
        for my $i ( 3 .. $n ) {
            # s1 is sequence converted to binary
            # s2 is s1 reversed
            my @s1 = map { dec2bin( $_, $i ) } @sequence;
            my @s2 = reverse @s1;

            # we append 0 to all entries in s1
            # and 1 to all the s2 entries
            @s1 = map { '0' . $_ } @s1;
            @s2 = map { '1' . $_ } @s2;

            # and then we join the two into one,
            my @s3 = ( @s1, @s2 );
            @sequence = map { bin2dec($_) } @s3;
        }
    }

    # JSON object here because it makes this function more
    # "pure"
    my $json = JSON->new->space_after;
    say $json->encode( \@sequence );
}

# not the dec2bin given by the Perl Cookbook, because
# we need to control the number of bits, because both
# 00000010 and 010 are 2, but only one behaves correctly
# when 1 is prepended.
# By the way, I LOVE sprintf.
sub dec2bin ( $n, $i = 2 ) {
    return sprintf "%0${i}b", $n;
}

# bin2dec as taken from the Perl Cookbook
sub bin2dec ($bin) {
    return unpack( "N", pack( "B32", substr( "0" x 32 . $bin, -32 ) ) );
}
