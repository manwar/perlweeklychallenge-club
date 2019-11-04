#!/usr/bin/env perl6
 
use v6;

my %*SUB-MAIN-OPTS = :named-anywhere;

#| Print help text
multi sub MAIN( Bool :h($help) where so * ) {
    say $*USAGE;
}

#| Print the times table up to 11
multi sub MAIN() {
    .say for get-header();
    .say for (1..11).map( { get-row($_) } );
}

sub format-row( *@data ) {
    sprintf " %2s | %3s %3s %3s %3s %3s %3s %3s %3s %3s %3s %3s", @data;
}

sub get-header() {
    ( format-row( "x", |(1..11) ), "-" x 49 );
}

sub get-row( $val ) {
    format-row( $val, |( "" xx $val-1 ), |($val..11).map( * * $val ) );
}
