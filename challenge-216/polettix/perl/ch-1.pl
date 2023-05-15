#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';

my %code = map { $_ => 1 } split m{}mxs, lc(shift) =~ s{[^a-z]}{}rgmxs;
my @words = grep {
   my %word = map { $_ => 1 } grep { $code{$_} } split m{}mxs, lc($_);
   scalar(keys(%code)) == scalar(keys(%word));
} @ARGV;
{ local $" = "', '"; say "('@words')" if @words }
