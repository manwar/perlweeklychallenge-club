#!/usr/bin/perl

use strict;
use warnings;
use Test::More;

sub shuffle_string {
    my ( $string, @indices ) = @_;

    my @chars = split //, $string;
    my @shuffled;

    for my $i ( 0 .. $#indices ) {
        $shuffled[ $indices[$i] ] = $chars[$i];
    }

    return join '', @shuffled;
}

my $string  = "lacelengh";
my @indices = ( 3, 2, 0, 5, 4, 8, 6, 7, 1 );
is( shuffle_string( $string, @indices ), "challenge" );

$string  = "rulepark";
@indices = ( 4, 7, 3, 1, 0, 5, 2, 6 );
is( shuffle_string( $string, @indices ), "perlraku" );

done_testing();
