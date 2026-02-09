#!/usr/bin/env perl

use Modern::Perl;

@ARGV or die "usage: $0 nums...\n";
say((sort {$a<=>$b} map {abs($_)} @ARGV)[0]);
