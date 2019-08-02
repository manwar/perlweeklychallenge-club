#!/usr/bin/perl -w
use strict;
use List::Util qw/sum/;

my @nivens = grep {
    $_ and not $_ % sum split //;
} 0..50;

print join("\n", @nivens), "\n";
