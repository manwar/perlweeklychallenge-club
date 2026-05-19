#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

sub main (@list) {
    # The last value is the 'n' value
    my $n = pop(@list);
    my $length = scalar(@list);

    my @result = ();

    # If the list is too short, return None
    if ( $length < $n ) {
        say -1;
        return;
    }

    # Calculate how many items each part has, and how many parts have an extra digit
    my $item_length = int( $length / $n );
    my $extra_first = $length % $n;

    foreach my $i ( 1 .. $n ) {
        # Determine how many items this part has, and add them to the result
        my $this_length = $i <= $extra_first ? $item_length + 1 : $item_length;
        push @result, "(" . join( ",", splice( @list, 0, $this_length ) ) . ")";
    }

    say "(" . join( ", ", @result ) . ")";
}

main(@ARGV);
