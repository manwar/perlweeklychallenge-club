#!/usr/bin/perl

use strict; use warnings;

my $N = $ARGV[0] || die "Please enter a decimal value less than 256";

die "Please enter a decimal value less than 256" unless(($N > 0) && ($N < 256));

my $N_Bin = sprintf ("%.8b", $N);

my ($first, $second) = reverse ($N_Bin =~ /(\d{1,4})(\d{1,4})/);

my $decimal = oct("0b".join ('', $first, $second));

print "Output:$decimal\n";