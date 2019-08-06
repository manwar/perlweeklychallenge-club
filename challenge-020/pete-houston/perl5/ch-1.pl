#!/usr/bin/env perl
#===============================================================================
#
#        USAGE: ./ch-1.pl STRING
#
#  DESCRIPTION: Split argument string on character change
#
#===============================================================================

use strict;
use warnings;

die "No argument string given.\n" unless defined $ARGV[0];
my @chars = split //, $ARGV[0];
my @out = shift @chars;
while (my $next = shift @chars) {
    if (substr ($out[-1], 0, 1) eq $next) {
        $out[-1] .= $next;
    } else {
        push @out, $next;
    }
}
print "Result is @out\n";
