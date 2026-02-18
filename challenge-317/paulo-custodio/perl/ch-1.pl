#!/usr/bin/env perl

use Modern::Perl;

my @words = split ' ', <>;
chomp(my $word = <>);
my $acronym = join '', map {substr($_,0,1)} @words;
say $word eq $acronym ? "true" : "false";
