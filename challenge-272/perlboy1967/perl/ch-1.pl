#!/bin/perl

=pod

The Weekly Challenge - 272
- https://theweeklychallenge.org/blog/perl-weekly-challenge-272

Author: Niels 'PerlBoy' van Dijke

Task 1: Defrang IP Address
Submitted by: Mohammad Sajid Anwar

You are given a valid IPv4 address.

Write a script to return the defranged version of the given IP address.

|| A defranged IP address replaces every period “.” with “[.]".

=cut

use v5.32;
use feature qw(signatures);
use common::sense;

use Test2::V0 qw(-no_srand);;

use Net::IP qw(ip_is_ipv4);

sub defrangIpAddress ($ipv4) {
  ip_is_ipv4($ipv4) ? $ipv4 =~ s#\.#[.]#gr : $ipv4;
}

is(defrangIpAddress('1.1.1.1'),'1[.]1[.]1[.]1','Example 1');
is(defrangIpAddress('255.101.1.0'),'255[.]101[.]1[.]0','Example 2');
is(defrangIpAddress('dead::beaf'),'dead::beaf','Own example');

done_testing;

