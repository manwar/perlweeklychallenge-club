#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub main {
    my ( $D, $S ) = @_;

    # Sanity check
    die "You must specify two strings\n" unless defined $S and defined $D;
    die "The second string must have an even number of characters\n" if length($D) % 2;

    # Build regexp of characters we want to remove
    my $open = my $close = '[^';
    while ( $D =~ /(.)(.)/g ) {
        my ( $o, $c ) = ( $1, $2 );
        # If it's not a alphanumeric character, we can safely escape it
        $open  .= $o =~ /[a-z0-9]/i ? $o : "\\$o";
        $close .= $c =~ /[a-z0-9]/i ? $c : "\\$c";
    }

    $open  .= ']';
    $close .= ']';

    # Apply the regexp, and display the results
    ( my $opening = $S ) =~ s/$open//g;
    ( my $closing = $S ) =~ s/$close//g;
    say $opening;
    say $closing;
}

main(@ARGV);
