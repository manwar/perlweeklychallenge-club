#!/usr/bin/env perl

use Modern::Perl;

my $n = shift || 0;
my $root = $n ** (1/3);
my $have_root = (int($root) == $root);
say $have_root ? 'true' : 'false';
