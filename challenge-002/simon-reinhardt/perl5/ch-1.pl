#!/usr/bin/env perl
use 5.020;
use warnings;
use strict;
use integer;

## Problem1

my $string = "-0123 abcd 001234 00 01 0023 -0123";
say $string;
$string =~ s/(?<!-)0+(?=[1-9][0-9]*)//g;
say $string;
