#!/usr/bin/env perl

use strict;
use warnings;

use List::Util qw(max reduce);

sub center {
    # Get length of the longest string
    my $maxlen = reduce { max($a, length $b) } 0, @_;

    # Add the needed spaces to the beginning of each string
    return map { ' ' x (($maxlen - length) / 2) . $_ } @_;
}

my @lines;
while (<>) {
    chomp;
    push @lines, $_;
}
for (center(@lines)) {
    print $_, "\n";
}
