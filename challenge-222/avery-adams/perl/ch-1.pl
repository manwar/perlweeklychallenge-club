#!/usr/bin/perl
use strict;
use v5.24;
my @sorted = sort @ARGV;
my $matches;
for (my $i = 0; $i <= $#ARGV; $i++) {$matches++ if $ARGV[$i] == $sorted[$i]}
say $matches // 0;
