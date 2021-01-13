#!/usr/bin/env perl
# -*- Mode: cperl; cperl-indent-level:4 tab-width: 8; indent-tabs-mode: nil -*-
# -*- coding: utf-8 -*-

use strict; use warnings;
use v5.26;
use List::Util qw(all);

sub usage {
    say 'perl ch-1.pl [-v] <string> <string>', "\n",
        'ex) perl ch-1.pl "perlraku" "perlrakuperlrakuperlraku"';
}

sub unsafe_commonDivisors($$) {
    my ( $l, $r ) = @_;
    all { int($_) eq $_ } $l, $r or die "both should be numbers";

    my $min = $l < $r ? $l : $r;
    map { ( $l % $_ or $r % $_ ) ? () : $_  } 1 .. $min;
}

my @f_ARGV = grep { ! /-(v|d|-*verbsose|-*debug)/ } @ARGV;
my ( $A, $B ) = @f_ARGV;

our $d = @f_ARGV != @ARGV; # turn on verbose

all { defined $_ and length $_ > 0 } $A, $B or usage, exit 0;

my @commonBaseWords;

for my $cdv ( unsafe_commonDivisors( length $A, length $B ) ) {
    my $mcb = substr( $A, 0, $cdv ); # (m)aybe (c)ommon (b)ase string
    ( all
         { my @m = /$mcb/g;

           say STDERR "`$_' contains `$mcb'", ": ",
               (scalar @m), ", must be ", (length($_) / $cdv) if $d;

           scalar( @m ) == (length($_) / $cdv)

         } $A, $B
    ) and push @commonBaseWords, $mcb;
}

say join(", ", @commonBaseWords);
