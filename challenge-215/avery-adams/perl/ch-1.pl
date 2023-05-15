#!/usr/bin/perl

use strict;
use v5.24;

my $removed = 0;
foreach (@ARGV) {if ($_ ne join('', sort(split(//, $_)))) {$removed++}}
say $removed;
