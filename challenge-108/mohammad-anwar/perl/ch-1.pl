#!/usr/bin/perl

use strict;
use warnings;

my $n = 1;
\$n =~ /SCALAR\((.*)\)/ and print "$1\n";
