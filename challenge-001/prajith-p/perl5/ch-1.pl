#!/usr/bin/perl

use strict;
use warnings;
my $str = "Perl Weekly Challenge";
my $count = ( $str  =~ s/e/E/g );
print "string: " . $str . ", count: " . $count .  "\n";

