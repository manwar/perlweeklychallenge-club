#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';

use Getopt::Long;

my $verbose =  0;

GetOptions("verbose" => \$verbose);

my $a = $ARGV[0] || 1234;
my $b = $ARGV[1] || 5678;
my $i = 4;

die 'Please specify digits only for $a' unless $a =~ /^\d+$/;
die 'Please specify digits only for $b' unless $b =~ /^\d+$/;

say ": 1: $a" if $verbose;
say ": 2: $b" if $verbose;

($a, $b) = ($b, $a . $b);

say ": 3: $b" if $verbose;

while (length($b) < 51)
{
  ($a, $b) = ($b, $a . $b);  
  say ": " . $i++ . ": $b" if $verbose;
}

say substr($b, 50, 1);
