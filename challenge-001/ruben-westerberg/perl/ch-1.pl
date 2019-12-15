#!/usr/bin/env perl
use strict;
use warnings;

my $string="Perl Weekly Challenge";
print "Original string: $string\n";
print "Total replacements performed ",$string =~ s/e/E/g,"\n";
print "Modified string: $string\n";
