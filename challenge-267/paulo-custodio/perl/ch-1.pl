#!/usr/bin/env perl

use Modern::Perl;
use List::Util 'product';

my $prod = product(@ARGV);
say $prod>0 ? 1 : $prod==0 ? 0 : -1;
