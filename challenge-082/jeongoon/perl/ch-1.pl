#!/usr/bin/env perl
# -*- Mode: cperl; cperl-indent-level:4 tab-width: 8; indent-tabs-mode: nil -*-
# -*- coding: utf-8 -*-

use strict; use warnings;
use v5.26;
use List::Util qw(all);

sub usage {
    say 'Usage: perl ch-1.pl <natural num> <natural num>', "\n",
        'ex) perl ch-1.pl 12 18';
}

sub common_divisors_($$) {
    # note: do not check they are natural numbers.
    my ( $l, $r ) = @_;

    my @gcdFinders;

    @gcdFinders = (
        # for  0 ( == )
        sub { $l },
        # for  1 ( <  )
        sub { # left hand side is smaller but trust user input if given
            my ( $sm, $bg ) = @_ ? @_ : ($l, $r);
            if ( $bg % $sm == 0 ) { $sm }
            else {
                my $i = $sm;
                --$i while ( $sm % $i || $bg % $i );
                $i;
            }
        },
        # for -1 ( >  )
        sub { $gcdFinders[1]->( $r, $l ); }
        );

    my $gcd = $gcdFinders[ $l <=> $r ]->();
    map { ( $gcd % $_ ) ? () : $_  } 1 .. $gcd;
}

my ( $M, $N ) = @ARGV;

(  @ARGV == 2
   and
   all { int($_) eq $_ and $_ > 0 } $M, $N  ) or usage, exit 0;

say "(".join(", ", common_divisors_( $M, $N )).")";
