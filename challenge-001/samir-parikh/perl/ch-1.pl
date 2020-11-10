#!/usr/local/bin/perl

use warnings;
use strict;

my $phrase = "Perl Weekly Challenge";
my $count = $phrase =~ s/e/E/g;
print "$count\n$phrase\n";
