#!/usr/bin/env perl
use strict;
use warnings;

my $str = 'Perl Weekly Challenge';
print "There are ", $str =~ y/e/E/, " occurrences of E in '$str'\n";


