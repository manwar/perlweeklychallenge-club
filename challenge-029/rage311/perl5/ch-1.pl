#!/usr/bin/env perl

use 5.028;
use strict;
use warnings;

die 'Need brace expansion phrase as argument' unless
  my $input = $ARGV[0];

die 'No braces to expand' unless
  my ($pre, $exp, $post) = $input =~ /^\s*(.+?)\s*\{(.+)\}\s*(.+?)\s*$/;

say join ' ', $pre, $_, $post for split /,/, $exp;

