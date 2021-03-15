#!/usr/bin/perl

use strict;
use warnings;

my $S = $ARGV[0] || "";
my $N = $ARGV[1] || 0;

$N = $N%26;

my @chars = split //, $S;

foreach(@chars) {

    my $original_ascii = ord($_);
    my $shifted_ascii = $original_ascii-$N;

    if(($original_ascii < 91 && $shifted_ascii < 65) or ($original_ascii >= 97 && $shifted_ascii < 97)) {
      $shifted_ascii += 26;
    }

    print chr($shifted_ascii);
}

print "\n";
