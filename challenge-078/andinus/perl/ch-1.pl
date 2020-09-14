#!/usr/bin/perl

use strict;
use warnings;

die "usage: ./ch-1.pl [space seperated numbers]\n" unless @ARGV;

my @leader;
MAIN: while (my $arg = shift @ARGV) {
    foreach my $elm (@ARGV) {
        next MAIN if $arg < $elm;
    }
    push @leader, $arg;
}

print join(', ', @leader), "\n";
