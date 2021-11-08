#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures };
no warnings qw{ experimental };

my @examples;
push @examples,
    [ q{""[]()}, '"I like (parens) and the Apple ][+", they said.' ];
push @examples,
    [
    q{**//<>}, '/* This is a comment (in some languages) */ <could be a tag>'
    ];

for my $e (@examples) {
    my ( $delim, $string ) = $e->@*;
    my ($open, $close)  = find_pairs( $delim, $string );

    say <<"END";
    Input:  
        Delimiter pairs: $delim
        Search String: $string
    Output: 
        $open
        $close
END
}

sub find_pairs ( $delim, $string ) {
    my %left;
    my %right;
    my $left  = '';
    my $right = '';
    while ( length $delim ) {
        my $x = substr $delim, 0, 2;
        substr( $delim, 0, 2 ) = '';
        my ( $l, $r ) = split //, $x;
        $left{$l}  = 1;
        $right{$r} = 1;
    }
    for my $i ( 0 .. length $string ) {
        my $c = substr $string, $i, 1;
        $left  .= $c if $left{$c};
        $right .= $c if $right{$c};
    }
    return ( $left, $right );
}
