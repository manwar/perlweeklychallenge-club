#!/usr/bin/env perl
# -*- Mode: cperl; cperl-indent-level:4 tab-width: 8; indent-tabs-mode: nil -*-
# -*- coding: utf-8 -*-

use strict; use warnings;
use boolean qw(:all);

sub unsort ( @ ) { sort { (-1,1)[(rand 1)+0.46] } @_; }
sub map_ssprintf { map { sprintf "%#$_[0]d", $_ } @_[1..$#_]; }

sub gen_smallest_( $$ ) {
    my ( $s, $c ) = @_;         # (s)mallest (c)urrent
    # return true               if we couldn't find the smallest
    #                                   because we found new one
    # return false              if we couldn't find the smallest
    # return current smallest   if we find the one
    if ( isBoolean( $s ) || $s > $c ) {
        true                        # 0         && new smallest
    }
    else {
        ( $s < $c ) ? $s            # smallest  && keep smallest
                    : false         # 0         && keep smallest
    }
}

sub processSmallest ( @ ) {
    my $smallest = boolean( not 'given' );
    map {
        my $current_is_smallest_or_just = gen_smallest_ $smallest, $_;
        isTrue( $current_is_smallest_or_just ) and $smallest = $_;
        isBoolean( $current_is_smallest_or_just ) ? 0 : $smallest;
      } @_;
}

package main;

my $S = shift;

( defined $S and $S > 4 )
  or warn "Size not given: USING ",$S = 9," !!";

$" = ' ';
my ( @A, @S );
my $W = length( 2*$S-1 ); # for sprintf

@S = processSmallest ( @A = unsort $S.. 2*$S-1 );

print "\@A = (${\"}@{[map_ssprintf($W, @A)]}${\"})\n";
print "\@S = (${\"}@{[map_ssprintf($W, @S)]}${\"})\n";
