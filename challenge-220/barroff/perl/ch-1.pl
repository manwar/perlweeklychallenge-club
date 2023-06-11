#!/usr/bin/env perl

use v5.36;
use strict;
use warnings;

use List::Util qw( uniq );

sub common_characters (@words) {
    my %characters;
    my @letters = map( { uniq split( //, lc($_) ) } @words );
    map( { $characters{$_}++ } @letters );
    my @cc = sort grep( { $characters{$_} == @words } keys %characters );
    return \@cc;
}

#| Run test cases
sub MAIN() {
    use Test2::V0 qw( is plan );
    plan 2;

    is common_characters( "Perl", "Rust", "Raku" ), ['r'],
      'works for ("Perl", "Rust", "Raku")';
    is common_characters( "love", "live", "leave" ), [ 'e', 'l', 'v' ],
      'works for ("love", "live", "leave")';
}

MAIN();
