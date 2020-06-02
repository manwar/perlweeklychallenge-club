#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ postderef say signatures state switch };
no warnings qw{ experimental };

use Carp;
use JSON;
my $json = JSON->new->canonical->allow_nonref->pretty->space_after;

my $word = 'xyxx';

say rotate_string($word);

sub rotate_string( $word ) {
    say $word;
    my $l    = length $word;
    my $c    = 0;
    my $copy = $word;
    while (1) {
        my $m    = $c % $l;
        $c++;
        my @copy = split //, $copy;
        for ( 0 .. $m ) {
            push @copy, shift @copy;
        }
        $copy = join '', @copy;
        return $c if $word eq $copy;
        exit if $c > 10;
    }
    return 1;
}
