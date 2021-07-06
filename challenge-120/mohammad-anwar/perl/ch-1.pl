#!/usr/bin/perl

use strict;
use warnings;

my $N = $ARGV[0];
die "ERROR: Missing input number.\n" unless defined $N;
die "ERROR: Invalid number [$N].\n"  unless ($N =~ /\d+/ and $N <= 255);

my $b = '0b';
$b .= reverse(substr(sprintf("%08d", sprintf("%b", $N)), $_, 2)) for (0,2,4,6);
print oct($b);
