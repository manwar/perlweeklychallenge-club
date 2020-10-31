#!/usr/bin/env perl
# -*- Mode: cperl; cperl-indent-level:4 tab-width: 8; indent-tabs-mode: nil -*-
# -*- coding: utf-8 -*-

use strict; use warnings;
use v5.26;

sub splitSignedNumber ($) {
    local $_ = shift;
    /^([+-]*)([0-9]*)$/;
}

sub Ok      { 1 }
sub Invalid { 0 }

sub filter32Bit ($$;$) {
    my ( $s, $n, $lim_abs ) = @_;
    $lim_abs ||= limitAbs( $s, $n );
    my $n_with_sigin = $s . $n;

    ( (bless \$n_with_sigin, (($n le $lim_abs) ? Ok : Invalid )), #  0 # eq
      (bless \$n_with_sigin, Invalid),                            #  1 # gt
      (bless \$n_with_sigin, Ok),                                 # -1 # lt
    )[ (length $n) <=> (length $lim_abs) ]
}

sub limitAbs ($$;$) { # $bit is optional
    my ( $s, $n, $bit ) = @_;
    $bit ||= 31;
    abs         # abs() for sure because if using 32bit variable,
    (1 << $bit) # that calculation is overflowed already
    - ( $s ne '-' )
}

sub reverseIntStr ($) {
    my $nstr = shift;
    my ( $s, $n ) = splitSignedNumber $nstr;

    ( my $rn = reverse $n ) =~ s/^0+//g;
    return "0" unless length $rn;

    ( $s eq '-' ? '-' : '' ).$rn;
}

package main;

my $N = shift;
my $reversed = reverseIntStr $N;
my ( $sign, $number ) = splitSignedNumber $reversed;
say "Input:";

say "Sign:  (@{[(($sign) ||= '+')]})"; # like: Sign: (+)
say "Value: ".$number;

my $lim_abs = limitAbs( $sign, $number );
my $result = filter32Bit( $sign, $number );

if ((ref $result) eq Ok) {
    say "Reversed: " . $$result;
}
else {
    say "Reversed: " . $$result;
    say "However limit value: " . ($sign < 0 ? '-' : ' ').$lim_abs;
    say "Therefore: " . (ref $result);
}
