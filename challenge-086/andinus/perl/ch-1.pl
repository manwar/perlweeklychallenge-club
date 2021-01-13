#!/usr/bin/perl

use strict;
use warnings;

die "usage: ./ch-1.pl <integers \@N> <integer \$A>\n"
    unless scalar @ARGV >= 3;

my $A = pop @ARGV;
my @N = @ARGV;

while (my $int = shift @N) {
    foreach (@N) {
        my $diff = $int - $_;
        print "1\n" and exit 0 if ($diff == $A or $diff == -$A);
    }
}
print "0\n";
