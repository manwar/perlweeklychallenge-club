#!/usr/bin/env perl

use v5.26;
use warnings;
use feature qw( signatures );
no warnings qw( experimental::signatures );

sub reshape( $matrix, $r, $c ) {
    my @all_elements = map @$_, @$matrix;
    return undef
        unless @all_elements == $r * $c;
    my $reshaped = [];
    push @$reshaped, [ splice @all_elements, 0, $c, () ]
        while @all_elements;
    return $reshaped;
}

my @tests;
my ( $test, $matrix, $r, $c, $expected ) = ( "", [], 0, 0, undef );
while ( <DATA> ) {
    /^(?!expect)\S{2,}.*/ and do { $test = $&; next };
    /^\[.*/               and do { push @$matrix, [ /\d+/g ]; next };
    /^r (\d+)/            and do { $r = $1; next };
    /^c (\d+)/            and do { $c = $1; next };
    /^expect (.*)/ and do {
        $expected = $1;
        push @tests, [ $test, $matrix, $r, $c, $expected ];
        ( $test, $matrix, $r, $c, $expected ) = ( "", [], 0, 0, undef );
        next;
    };
}

for ( @tests ) {
    my ( $test, $matrix, $r, $c, $expected ) = @$_;
    my $reshaped = reshape( $matrix, $r, $c );
    say $test;
    say "[ @$_ ]"
        for @$matrix;
    say "r $r";
    say "c $c";
    say $_ ? "[ @$_ ]" : 0
        for $reshaped && @$reshaped;
    say "";
}

use Test::More;
for ( @tests ) {
    my ( $test, $matrix, $r, $c, $expected ) = @$_;
    my $reshaped = reshape( $matrix, $r, $c );
    my $answer = $reshaped ? join( " ", map "[ @$_ ]", @$reshaped ) : 0;
    is $answer, $expected, $test;
}

done_testing;

__DATA__

Example 1
[ 1 2 ]
[ 3 4 ]
r 1
c 4
expect [ 1 2 3 4 ]

Example 2
[ 1 2 3 ]
[ 4 5 6 ]
r 3
c 2
expect [ 1 2 ] [ 3 4 ] [ 5 6 ]

Example 3
[ 1 2 ]
r 3
c 2
expect 0
