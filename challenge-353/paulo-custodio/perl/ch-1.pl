#!/usr/bin/env perl

use Modern::Perl;

@ARGV or die "usage: $0 sentences...\n";
my @words = sort {$a<=>$b} map {scalar @$_} map {[split ' ', $_]} @ARGV;
say $words[-1];
