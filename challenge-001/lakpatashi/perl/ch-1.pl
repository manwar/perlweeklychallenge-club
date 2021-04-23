#!/usr/bin/perl

use strict;
use warnings;

my $var = 'Perl Weekly Challenge';
print "Before:: $var\n";
my $repCount = $var =~ s/e/E/g;
print "After :: $var\n";
print "char Replaced:: $repCount\n";

