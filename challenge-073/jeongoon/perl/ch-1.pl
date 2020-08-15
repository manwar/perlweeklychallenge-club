#!/usr/bin/env perl
# -*- Mode: cperl; cperl-indent-level:4 tab-width: 8; indent-tabs-mode: nil -*-
# -*- coding: utf-8 -*-

use strict; use warnings;

BEGIN {
    $::debugging = 0;
    @ARGV =  map {
        my $d = /^--debug$/;
        $d && ++$::debugging;
        $d ? () : $_;
    } @ARGV;

    our $dprint = sub( @ ) {
        ++$|;
        print "[DBG] ",@_;
    };
    *::dprint = $::debugging ? $dprint : sub (@) {};
}

sub unsort ( @ ) { sort { (-1,1)[(rand 1)+0.46] } @_ }

sub groupMinimumList ( @ ) { # $size, @_
    my $s = shift;
    # let's memorise the position(index) when we find the mimum value
    #   if previous minimum position is gone,
    #      A compare everything in the group
    #        1. memo the position, 2. push the value into result
    #   else e.g. if found
    #      B compare only between two values
    #        1. memo the position, 2. push the value into result
    my $min  = undef;
    my $i    = -$s +1;                 # index when whole sliding door is ready
    my $imax = scalar @_ -$s;          # same as $#_ -$s +1
    my $memo = -1;

    map {
        my $memo_inbound   = $memo > $i;
        my $door_inbound   = 0 <= $i && $i <= $imax;

        if ( $door_inbound  && ! $memo_inbound ) {
                                        # compare everything in sliding door (A)
            # XXX: no seprate function for debugging purpose
            $min  =  $_[ $memo = $i ];
            ::dprint "(A) $i: min $min at $memo\n";
            for my $d ( 1 .. $s -1 ) {
                if ( $min >= $_[$i+$d] ) { $min  = $_[ ($memo = $i+$d) ] }
                ::dprint "(A) $i: min $min at $memo\n";
            }
        }
        else {
            if ( ! defined $min || $min >= $_ ) {
                                        # keep comparing between two      .. (B)
                $min  = $_;
                $memo = $i + ($s -1);   # memorise the *real* index in array
                ::dprint "(B) $i: min $min at $memo\n";
            }
            else {
                ::dprint "(B) $i: min $min at $memo (no need to compare at all)\n";
            }
        }
        ++$i;
        $door_inbound ? $min : ();
    } @_;
}

sub groupMinimumListComplex ( @ ) { # $size, @_
    my $s = shift;

    my @min  = (); # using array
    my @memo = (); #    ditto

    my $i    = -$s +1;
    my $imax = scalar @_ -$s;

    # in this case we are comparing numbrers but. what if comparing
    # more complex object and comparing process is not very delightful?

    map {
      isEvil:
        my $memo_inbound = scalar @memo && $memo[0] > $i;
        my $door_inbound = 0 <= $i && $i <= $imax;

        if ( $door_inbound  && ! $memo_inbound ) {
                                        # compare everything in sliding door (A)
            # Experiment:
            # but what if we have another minimum value memorised
            # in bound of the group (because we just disgard one element)
            if ( scalar @memo ) {
                shift @memo; shift @min;
                if ( scalar @memo ) {
                    ::dprint "(B?) Found another minimum value in bound.\n";
                    goto isEvil;
                }
            }

            # compare everything in group again
            @memo = ( $i );
            @min  =  ( $_[ $i ] );
            ::dprint "(A0) $i: min $min[0] at $memo[0]\n";

            for my $d ( 1 .. $s -1 ) {
                my $k = $i+$d;
                if ( $min[0] >= $_[$k] ) { # new value is minimum and
                    if ( $memo[0] > $k ) { # located in left hand side
                        unshift @min, $_[$k];
                        unshift @memo,   $k;
                        ::dprint "(A+) $i: min $min[0] at $memo[0]\n";
                    }
                    else { # or just forget it. :(
                        @memo = (     $k   );
                        @min  = ( $_[ $k ] );
                        ::dprint "(A=) $i: min $min[0] at $memo[0]\n";
                    }
                }
            }
        }
        else {
            if ( scalar @min == 0 || $min[0] >= $_ ) {
                                        # keep comparing between two      .. (B)
                if ( scalar @min && $memo[0] > $i ) {
                    unshift @min, $_;
                    unshift @memo, $i + ($s -1); # memorise the *real* index in array
                    ::dprint "(B+) $i: min $min[0] at $memo[0]\n";
                }
                else {
                    @min  = ( $_ );
                    @memo = ( $i + ($s -1) );
                    ::dprint "(B=) $i: min $min[0] at $memo[0]\n";
                }
            }
            else {
                ::dprint "(B) $i: min $min[0] at $memo[0] (no need to compare at all)\n";
                # XXX: don't change anything
                #      because minimum value was not at leftmost
                #      we can check again in next loop
            }
        }
        ++$i;
        $door_inbound ? $min[0] : ();
    } @_;
}

sub map_ssprintf { map { sprintf "%#$_[0]s", $_ } @_[1..$#_] }

package main;

my $S = shift;

(defined $S and $S > 2) or warn "Invalid sliding door size: USING ",$S = 3," !!";
my $FS = 10*int( .3* $S +.5 ); # reasonable value for (F)rame(S)ize
my @A  = unsort 0.. $FS-1;     # simply using max number from frame size

::dprint "Default My solution: \n";
my @M = groupMinimumList $S, @A;
::dprint "Another one: \n";
my @E = groupMinimumListComplex $S, @A;

$" = ' ';
my $W = length( $FS-1 ); # for sprintf

print "\$S = $S  |->  \$FS = $FS\n";
print "\@A = (${\"}@{[map_ssprintf($W, @A)]}${\"})\n";

my $diff = scalar @A - scalar @M;
my @G = ( " " ) x $diff;
my $gh  = int .5 * (scalar @G);
my @adj = ( $diff % 2 ) ? ( $", '' ) : ( '', $" );

print "\@M = ( $adj[0]".
  "@{[map_ssprintf($W,@G[0..$gh-1],@M,@G[$gh..$#G])]}$adj[1])\n";
print "\@E = ( $adj[0]".
  "@{[map_ssprintf($W,@G[0..$gh-1],@E,@G[$gh..$#G])]}$adj[1])\n";
print "Complex Method Failed\n" unless "@M" eq "@E";
