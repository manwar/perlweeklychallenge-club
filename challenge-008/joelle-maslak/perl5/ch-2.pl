#!/usr/bin/env perl
use v5.26;
use strict;
use warnings;

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

use autodie;
use List::Util qw(max);

if ( @ARGV > 1 )      { die("Provide only a filename of source lines") }
my $file = $ARGV[0] // "ch-2.txt";

#
# Copyright (C) 2019 Joelle Maslak
# All Rights Reserved - See License
#

open my $fh, '<', $file;
my @lines;
while (my $line = <$fh>) {
    chomp $line;
    push @lines, $line;
}
close $fh;

say join("\n", center(@lines));

sub center(@lines) {
    my $maxlen = max map { length($_) } @lines;
    return map { " " x (($maxlen - length($_))/2) . $_ } @lines;
}

