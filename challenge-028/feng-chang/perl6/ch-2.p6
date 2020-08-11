#!/bin/env perl6

my $clock = Supply.interval: 1;
$clock.tap: { print "\r", DateTime.now.hh-mm-ss };

signal(SIGINT).tap({ put "\r{ DateTime.now.hh-mm-ss }  "; exit 0; });

sleep ∞;
