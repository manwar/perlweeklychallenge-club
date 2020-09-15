#!/usr/bin/env perl

use strict;
use warnings;
use v5.30;

my @A = (7, 4, 2, 6, 3);
my @B = (1, 3, 4);

for (@B) { say join ' ', (@A[$_..$#A],@A[0..$_-1]) };
