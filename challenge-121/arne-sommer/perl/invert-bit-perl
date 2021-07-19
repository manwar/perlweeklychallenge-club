#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use Getopt::Long;

my $verbose = 0;

GetOptions("verbose" => \$verbose);

my $m = $ARGV[0] // "";

die "Please specify an integer in the range 0..255 (first arg)" if $m !~ /^\d+$/ || $m > 255;

my $n = $ARGV[1] // "";
	      
die "Please specify an integer in the range 1..8 (second arg)" if $n !~ /^[1-8]$/;

my $mask   = 2 ** ($n -1);
my $result = $m ^ $mask;

if ($verbose)
{
  say ": Binary: ", sprintf('%08b', $n);
  say ": Mask:   ", sprintf('%08b', $mask);
  say ": XOR:    ", sprintf('%08b', $result);
}

say $result;
