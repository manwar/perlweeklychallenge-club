#! /usr/bin/perl

use strict;
use warnings;

my $a=shift @ARGV or die "need two parameters\n";
$a =~ s/[^A-Za-z]//g;
my %s=map {$_ => 1} split '',$a;

my $b=shift @ARGV or die "need two parameters\n";
$b =~ s/[^A-Za-z]//g;
my $t=0;
map {$t += (exists $s{$_}?1:0)} split '',$b;

print "$t\n";
