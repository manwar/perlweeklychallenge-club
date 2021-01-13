#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

use List::Util 'sum';

sub _char_at {
    my ( $lines, $x, $y ) = @_;
    return '' if $y > $#$lines or $x > length( $lines->[$y] );
    return substr( $lines->[$y], $x, 1 );
}

sub _next_line {
    my ( $lines, $x, $y, $direction ) = @_;

    # See if there is a / or \ 1 line below ...
    my $delta = $direction eq 'left' ? -1  : 1;
    my $char  = $direction eq 'left' ? '/' : '\\';
    if ( $y < $#$lines and _char_at( $lines, $x + $delta, $y + 1 ) eq $char ) {
        # ... and return the corresponding number below that
        return ( _char_at( $lines, $x + $delta * 2, $y + 2 ), $x + $delta * 2, $y + 2 );
    }
    return;
}

sub _walk_path {
    my ( $lines, $x, $y, $digits ) = @_;
    push @$digits, _char_at( $lines, $x, $y );

    foreach my $direction (qw(left right)) {
        # See if there are any child elemnts of this value
        if ( my ( $char, $new_x, $new_y ) = _next_line( $lines, $x, $y, $direction ) ) {
            # Go to the child node
            _walk_path( $lines, $new_x, $new_y, $digits );
        }
    }
}

sub main {
    # Read the input from STDIN (e.g. by piping a file)
    my @lines = <>;

    # Find the number on the first line.
    my ( $spaces, $number ) = ( $lines[0] =~ /^(\D*)(\d)/ );

    # Walk the paths
    my @digits    = ();
    my @this_path = ($number);
    _walk_path( \@lines, length($spaces), 0, \@digits );

    say join ' -> ', @digits;
}

main();
