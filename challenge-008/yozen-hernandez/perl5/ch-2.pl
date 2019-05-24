#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use List::Util qw(max);

my @centered = center("This", "is", "a test of the", "center function");;

say join( "\n", @centered );

sub center {
    my $longest_len = max( map { length $_ } @_ );

    map {
        my $pad = ( $longest_len - length($_) + 1 ) / 2;
        ( " " x $pad ) . $_;
    } @_;
}
