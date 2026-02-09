#!/usr/bin/env perl

use Modern::Perl;

@ARGV==1 or die "usage: $0 string\n";
my $string = $ARGV[0];
1 while $string =~ s/(.)\1//;
say $string;
