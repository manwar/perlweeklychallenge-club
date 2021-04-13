#!/usr/bin/perl

use strict;
use warnings;

# PART 1

my $var = 'Perl Weekly Challenge';
print "Before:: $var\n";
my $repCount = $var =~ s/e/E/g;
print "After :: $var\n";
print "Pattern matched:: $repCount\n";

