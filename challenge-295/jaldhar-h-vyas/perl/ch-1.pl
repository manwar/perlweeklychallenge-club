#!/usr/bin/perl
use v5.38;

my $str = shift;
my @words = @ARGV;

for my $word (@words) {
    $str =~ s/$word//g;
}

say length $str < 1 ? 'true' : 'false';