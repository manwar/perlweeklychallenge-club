#!/usr/bin/env perl
use v5.24;
use FindBin '$Bin';
use lib "$Bin/local/lib/perl5";
use ntheory 'is_prime';
use List::Util 'sum';

my $M = shift // 100;
say join ', ', grep { is_prime($_) && is_prime sum split m{}mxs } 2 .. $M;
