#!/usr/bin/env perl

use strict;
use warnings;

use List::Util qw( max );

sub max_xor {
    my @all_xors;
    for my $i ( 0 .. ( $#_ - 1 ) ) {
        for my $j ( $i..$#_ ) {
            push @all_xors, $_[$i] ^ $_[$j];
        }
    };
    return max( @all_xors );
}

sub max_xor_2 {
    my @all_xors;
    for my $i ( 0..$#_ ) {
        push @all_xors, map $_[$i] ^ $_[$_], $i..$#_;
    };
    return max( @all_xors );
}

sub xor_slice { return map $_[0] ^ $_, @_[1..$#_] }
sub max_xor3 {
    return max( map xor_slice( @_[$_..$#_] ), 0 .. ( $#_ - 1 ) );
}

use Test::More;

my @tests = (
    [ [1,2,3,4,5,6,7], 7  ],
    [ [2,4,1,3],       7  ],
    [ [10,5,7,12,8],   15 ],
);

is max_xor3( @{$_->[0]} ), $_->[1],
    "third_highest( @{$_->[0]} ) == " . ( $_->[1] // "undef" )
    for @tests;

done_testing;
