#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ fc postderef say signatures state switch };
no warnings qw{ experimental };

use List::Util qw{ sum0 max };

my $bin  = '010';

my $length = -1 + length $bin;
my $record;

for my $l ( 0 .. $length ) {
    for my $r ( $l .. $length ) {
        my $flipped = flip( $bin, $l, $r );
        my $sum     = sum0( split //, $flipped );
        push $record->{$sum}->@*, [ $sum, $l, $r, $flipped ];
    }
}
say qq{Base: $bin};
say join ' ', qw{ I L R String };
say '=' x 12;
for my $bin ( map { $record->{$_}->@* } max keys $record->%* ) {
    say join ' ', map { $bin->[$_] } 0 .. 3;
}

sub flip ( $bin, $l, $r ) {
    for my $n ( $l .. $r ) {
        substr( $bin, $n, 1 ) = int !substr( $bin, $n, 1 );
    }
    return $bin;
}

