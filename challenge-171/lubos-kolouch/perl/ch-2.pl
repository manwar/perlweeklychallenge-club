#!/usr/bin/perl

use strict;
use warnings;

sub compose {
    my ( $f, $g ) = @_;

    return sub {
        my @args = @_;
        return $f->( $g->(@args) );
    }
}

sub add_10 {
    my $x = shift;
    return $x + 10;
}

sub multiply_2 {
    my $x = shift;
    return $x * 2;
}

my $h = compose( \&add_10, \&multiply_2 );

print $h->(5), "\n";    # 20
