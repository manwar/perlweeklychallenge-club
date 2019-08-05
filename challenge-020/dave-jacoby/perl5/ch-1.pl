#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ fc postderef say signatures state switch };
no warnings
    qw{ experimental::postderef experimental::smartmatch experimental::signatures };

if (@ARGV) {
    for my $string (@ARGV) {
        say $string;
        say join ', ', map { qq{"$_"} } split_on_change($string);
        say '';
    }
}
else {
    my $string = 'ABBCDEEF';
    say $string;
    say join ', ', map { qq{"$_"} } split_on_change($string);
    say '';
}

sub split_on_change ( $string ) {
    my @array;
    my $cache = '';
    for my $l ( split //, $string ) {
        state $m = '';
        if ( $l eq $m ) {
            $cache .= $l;
        }
        else {
            $m = $l;
            push @array, $cache;
            $cache = $l;
        }
    }
    push @array, $cache;
    @array = grep { length $_ } @array;
    return wantarray ? @array : \@array;
}
