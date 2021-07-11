#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use Getopt::Long;

my $verbose = 0;

GetOptions("verbose" => \$verbose);

my $T = $ARGV[0] // "";

die "Please specify a HH:MM value" unless $T =~ /^[01]\d\:[0-5]\d$/;

my ($hour, $min) = split(":", $T);

die "Hours 00-12 only" if $hour > 12;

$hour -= 12 if $hour >= 12;

my $degrees_h = 360 / 12 * $hour + $min / 2;
my $degrees_m = 360 / 60 * $min;

if ($verbose)
{
  say ": Degree H: $degrees_h";
  say ": Degree M: $degrees_m";

}

my $diff = abs($degrees_h - $degrees_m);

say "$diff degree";