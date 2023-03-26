#!/usr/bin/perl

use v5.16;
use warnings;
use experimental 'signatures';

main: {
    my $n = shift;
    say "female: @{[map female($_), 0 .. $n]}";
    say "male:   @{[map male($_), 0 .. $n]}";
}

sub female ($n) {
    return 1 if $n == 0;
    $n - male(female($n - 1));
}

sub male ($n) {
    return 0 if $n == 0;
    $n - female(male($n - 1));
}
