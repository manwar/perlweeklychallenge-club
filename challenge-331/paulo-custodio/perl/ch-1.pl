#!/usr/bin/env perl

use Modern::Perl;

my @words = split ' ', <>;
say @words==0 ? 0 : length($words[-1]);
