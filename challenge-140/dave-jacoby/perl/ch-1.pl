#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say state postderef signatures };
no warnings qw{ experimental };

my @examples;
push @examples, [ 11,  1,  100 ];
push @examples, [ 101, 1,  110 ];
push @examples, [ 100, 11, 111 ];

for my $example (@examples) {
    my ( $a, $b, $solution ) = $example->@*;
    my $c = add_binary( $a, $b );
    my $d = real_add_binary( $a, $b );
    say <<"END";
    Input: \$a = $a; \$b = $b
    Output: $c
    We know by:  $d 
    And also by: $solution
END
}

sub add_binary ( $a, $b ) {
    my @output;
    my $r = 0;
    my @a = split //, $a;
    my @b = split //, $b;

    while ( @a || @b ) {
        my $wa = pop @a;
        my $wb = pop @b;
        $wa //= 0;
        $wb //= 0;
        my $sum = $wa + $wb + $r;
        $r = $sum > 1 ? 1 : 0 ;
        unshift @output, $sum % 2? 0 : 1;
    }
    unshift @output, 1 if $r;
    return join '', @output;
}

sub real_add_binary ( $a, $b ) {

    # convert from binary to decimal
    my $ra = oct( '0b' . $a );
    my $rb = oct( '0b' . $b );

    # decimal addition?
    my $rc = $ra + $rb;

    # reconversion and return
    return sprintf '%b', $rc;
}
