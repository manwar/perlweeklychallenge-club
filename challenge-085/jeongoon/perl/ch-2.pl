#!/usr/bin/env perl
# -*- Mode: cperl; cperl-indent-level:4 tab-width: 8; indent-tabs-mode: nil -*-
# -*- coding: utf-8 -*-

use utf8;
use strict; use warnings;
use v5.26;

BEGIN {
    binmode( STDERR, ':utf8' );
    binmode( STDOUT, ':utf8' );
}

our @POW_UTF8 = qw{⁰ ¹ ² ³ ⁴ ⁵ ⁶ ⁷ ⁸ ⁹};
sub pow_utf8__ ($) {  # does not check whether integer value or not
    join "", @POW_UTF8[ split "", $_[0] ]
}

sub maxFactor ($) { # find k where k² <= $_[0]
    int             # -> as an iteger value
      sqrt $_[0]
}

sub findPowerByComparing_ ($) { # note: do not check when N == 1
    my $N = shift;
    my $fac = maxFactor $N;

  MAYBE_NEXT_FACTOR:
    {
        my $k = $fac;
        my $pow = 1;
        {
            $k = $k * $fac;     # produce k², k³ ...
            ++$pow;
            if ( $k == $N ) {
                return [ $fac, $pow ];
            }
            elsif ( $k < $N
                    and ( $N % $k == 0 ) # but we don't need to go further
                                         # if $k is not a modular
                  ) {
                redo;
            }
        }
        redo if ( --$fac > 1 );
    }

    # could not find any integer where a to the power of b = N
    return undef;
}

sub findPowerByLog_ ($) {
    my $N = shift;
    my $fac = maxFactor $N;

  MAYBE_NEXT_FACTOR:
    {
        {
            my $pow = log($N) / log($fac);
            if ( int $pow == $pow ) {
                return [ $fac, $pow ];
            }
        }
        redo if ( --$fac > 1 );
    }

    # could not find any integer where a to the power of b = N
    return undef;
}

package main;


my @ARGV_ = grep { !/^--*l(og)*/ } @ARGV;
my $finder =
  ( @ARGV_ == @ARGV )   ? \&findPowerByComparing_
                        : \&findPowerByLog_;

my $N = shift @ARGV_;

( defined $N and $N > 0 ) or die "Invalid number";

if ( $N == 1 ) {
    say "1 as 1²";
    exit 0;
}

else {
    my $fac = maxFactor $N;
    my $pair = $finder->( $N );
    defined $pair or say("0"), exit 1;

    say "1 as $N == $$pair[0]" . pow_utf8__( $$pair[1] );
}
