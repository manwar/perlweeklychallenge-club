#!/usr/bin/env perl

use lib './lib';
use OddOneOut;

my $srv = OddOneOut->new;
use Data::Dumper;

print 'Input: ', join ', ', @ARGV, "\n";
print ' Output: ', $srv->count(@ARGV), "\n\n";

