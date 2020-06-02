#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;

sub last_word {
    my ( $string, $regex ) = @_;
    my @words = split /\s+/, $string;
    foreach ( reverse @words ) {
        return $_ if $_ =~ $regex;
    }
    return undef;
}

is( last_word( '  hello world', qr/[ea]l/ ), 'hello', 'hello world' );
is( last_word( "Don't match too much, Chet!",  qr/ch.t/i ), 'Chet!', 'Chet!' );
is( last_word( "spaces in regexp won't match", qr/in re/ ), undef,   'undef' );
is( last_word( join( ' ', 1 .. 1e6 ), qr/^(3.*?){3}/ ),
    '399933', 'long list of nums' );
done_testing;
