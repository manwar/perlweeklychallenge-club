#!/bin/env perl

use Modern::Perl;

my($encoded, $initial) = @ARGV;
my @encoded = map {$_+0} split ' ', $encoded;   # convert to number
$initial += 0;                                  # convert to number

my @decoded = ($initial);
for (@encoded) {
    push @decoded, $decoded[-1] ^ $_;
}

say "(", join(", ", @decoded), ")";
