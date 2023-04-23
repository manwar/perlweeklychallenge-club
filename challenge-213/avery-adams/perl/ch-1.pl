#!/usr/bin/perl
use strict;
use v5.24;

my (@even, @odd);
$_ % 2 ? push @odd, $_ : push @even, $_ for sort @ARGV;
say @even, @odd;
