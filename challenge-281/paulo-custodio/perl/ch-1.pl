#!/usr/bin/env perl

use Modern::Perl;

@ARGV==1 or die "Usage: $0 coordinates\n";
(my $coords = shift) =~ /^[a-h][1-8]$/ or die "Usage: $0 coordinates\n";

my @coords = split //, $coords;
my $light = (((ord($coords[0])-ord('a'))) & 1) ^ (($coords[1]-1) & 1);
say $light ? "true" : "false";
