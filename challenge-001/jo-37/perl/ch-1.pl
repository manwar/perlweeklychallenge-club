#!/usr/bin/perl

use v5.12;
use strict;
use warnings;

for ($a = 'Perl Weekly Challenge') {
	my $n = y/e/E/;
	say "$_: $n";
}
