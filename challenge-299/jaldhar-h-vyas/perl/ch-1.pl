#!/usr/bin/perl
use v5.38;

my $sentence = shift;
my @words = @ARGV;

for my $word (@words) {
    $sentence =~ s/$word\w+/$word/g;
}

say $sentence;