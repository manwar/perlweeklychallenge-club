#!/usr/bin/env perl
# Week 148 Task 1
# Eban Numbers
# Write a script to generate all Eban Numbers <= 100.
# An Eban number is a number that has no letter ‘e’ in it
# when the number is spelled in English (American or British).

use strict;
use warnings;
use feature qw/ say /;
use Lingua::EN::Numbers qw/ num2en /;

my $max = 100;

say "Eban Numbers <= $max:";
for ( 1 .. $max ) {
    ( num2en($_) =~ /e/i ) ? next : say $_;
}
