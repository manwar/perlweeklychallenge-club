#!/usr/bin/perl

use strict;
use warnings;

# PART 1

my $var = '000012340000';
print "Before:: $var\n";
my $repCount = $var =~ s/^0+//g;
print "After :: $var\n";
print "char Replaced:: $repCount\n";

