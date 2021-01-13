#!/usr/bin/env perl
# -*- Mode: cperl; cperl-indent-level:4 tab-width: 8; indent-tabs-mode: nil -*-
# -*- coding: utf-8 -*-

use strict; use warnings;
use v5.26;
use List::Util qw(all sum);


use Algorithm::Combinatorics;
# comment: I don't know why but this version is slow.

use FindBin;
use lib ( $FindBin::Bin );

sub usage {
    say 'Usage: perl ch-2.pl [-d|--debug] <natural num> ... ', "\n",
        'ex) perl ch-2.pl 12 2 10';
}

sub combinations ($$$) {
    my ( $list, $minSelection, $maxSelection ) = @_;
    map { Algorithm::Combinatorics::combinations( $list, $_ ) }
      $minSelection .. $maxSelection;
}

package main;

my @N = grep { ! /-(h|-*help)/ } @ARGV;
@N == @ARGV or usage, exit 0;

@N = grep { ! /-(d|-*debug)/ } @ARGV;
our $d = @N != @ARGV;

(  @N > 0
   and
   all { int($_) eq $_ and $_ > 0 } @N  ) or usage, exit 1;

@N == 1 and ( say( "0" ), exit 0 ); # already mimimum

my $totalSum = sum @N;
my $halfLen  = int( .5 * @N ); # reduce the combinations in half

# initial values ...
my $minElems = +@N;
my $minSum  = $totalSum;

for my $combi ( combinations( \@N, 1, $halfLen ) ) {
    my $aSum = sum @$combi;
    my $bSum = $totalSum - $aSum;

    my $curr =
      ( # $aSum == $bSum
       [ 0, ( scalar @$combi < $halfLen
              ? scalar @$combi : scalar( @N - @$combi) ) ],
        # $aSum  > $bSum
       [ $aSum - $bSum, scalar ( @N - @$combi) ],
        # $aSum  < $bSum
       [ $bSum - $aSum, scalar @$combi ] )[ $aSum <=> $bSum ];

    print "[sum: $$curr[0], elems: $$curr[1]] with @$combi ... " if $d;

    if ( $$curr[0] > $minSum ) {        # minimum sum not changed
        say "skipped." if $d;
        next;
    }
    elsif ( $$curr[0] < $minSum ) {     # minimum sum cahnged
                                        # so does minimum elements
        say "**minium sum changed**" if $d;
        ( $minSum, $minElems ) = @$curr;
    }
    elsif ( $$curr[1] < $minElems ) {   # minimum sum is same
        # also elements is less
        say "**minimum count changed**" if $d;
        $minElems = $$curr[1];
    }
    else {
        say "" if $d;
    }
}

say $minElems;
