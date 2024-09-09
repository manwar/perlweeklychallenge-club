#!/usr/bin/env perl

use strict;
use warnings;

open my $fh, '<', $0 or die "Couldn't open file $0 for reading: $!";
my $content = do { local $/; <$fh> };
close $fh;

my @words = $content =~ /(\S+)/g;

print $words[rand @words], "\n";
