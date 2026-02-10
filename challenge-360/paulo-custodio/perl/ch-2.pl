#!/usr/bin/env perl

use Modern::Perl;

@ARGV or die "usage: $0 words...\n";
say join " ", sort {lc($a) cmp lc($b)} @ARGV;

