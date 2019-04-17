#!/usr/bin/env perl
#
# First command line argument: letters to be used
# All other: dictionary files
# Example: ch-2.pl aabcdefz words

use strict;
use warnings;

my @l = split( '', shift );

while (<>) {
    my $w = $_;
    chomp $w;
    next if length $w > @l;
    foreach my $l (@l) {
        next if ( my $p = index $w, $l ) == -1;
        substr $w, $p, 1, '';
        next if length $w;
        print $_;
        last;
    }
}
