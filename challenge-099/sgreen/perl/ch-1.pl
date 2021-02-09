#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub main {
    my ( $string, $pattern ) = @_;

    # Sanity check
    die "You must enter a string\n"  unless defined $string;
    die "You must enter a pattern\n" unless defined $pattern;

    # Escape regexp meta characters, except ? and *
    $pattern =~ s/([\{\}\[\]\(\)\^\$\.\|\+\\])/\\$1/g;

    # Replace ? and *
    $pattern =~ s/\?/./g;
    $pattern =~ s/\*/.+/g;

    # Ensure entire match
    $pattern = "^$pattern\$";

    say $string =~ $pattern ? 1 : 0;
}

main(@ARGV);
