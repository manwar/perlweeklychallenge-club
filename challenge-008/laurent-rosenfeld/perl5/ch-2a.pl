#!/usr/bin/perl
use strict;
use warnings;
use feature qw / say /;
use List::Util qw / max /;

sub center {
    my $max_size =  max map length, @_;
    map { " " x (int ($max_size - length) / 2) . $_} @_;
}

my @strings = ("This", "is", "a test of the", "center function");
say for center @strings;
