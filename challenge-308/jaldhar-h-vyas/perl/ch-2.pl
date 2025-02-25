#!/usr/bin/perl
use v5.38;

my $initial = shift;
my @encoded = @ARGV;

my @decoded = ($initial);

for my $n (@encoded) {
    push @decoded, $n ^ $decoded[-1];
}

say q{(}, (join q{, }, @decoded), q{)};
