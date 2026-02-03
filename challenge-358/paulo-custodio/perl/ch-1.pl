#!/usr/bin/env perl

use Modern::Perl;
use List::Util qw(max);

@ARGV or die "usage: $0 strs...\n";
say max(map {/\D/ ? length($_) : 0+$_} @ARGV);
