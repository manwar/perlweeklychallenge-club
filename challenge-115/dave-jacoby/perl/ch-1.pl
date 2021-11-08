#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ postderef say signatures state };
no warnings qw{ experimental };

use Algorithm::Permute;

my @input;
push @input, [ "abc", "dea", "cd" ];
push @input, [ "ade", "cbd", "fgh" ];

for my $i (@input) {
    my $v = is_chain( $i->@* );
    say join " | ", $i->@*;
    say $v? 'We can form a circle' : 'We cannot for a circle';
    say ' ';
}

sub is_chain ( @links ) {
    my $p = Algorithm::Permute->new( [@links] );
    while ( my @res = $p->next ) {
        my $i = join '-', @res;
        my $c = 1;
        if ( f_char( $res[0] ) eq l_char( $res[-1] ) ) {
            for my $i ( 1 .. -1 + scalar @res ) {
                $c++ if l_char( $res[ $i - 1 ] ) eq f_char( $res[$i] );
            }
            return 1 if $c == scalar @links;
        }
    }

    return 0;
}

sub f_char( $str ) {
    return substr( $str, 0, 1 );
}

sub l_char( $str ) {
    return substr( $str, -1 + length $str, 1 );
}
