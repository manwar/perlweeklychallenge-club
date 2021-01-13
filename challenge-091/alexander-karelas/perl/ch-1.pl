#!/usr/bin/env perl

use v5.30;
use warnings;

my $number = $ARGV[0];
defined $number or die "Usage: $0 <number>";

while (length $number) {
    $number =~ s/^((\d)\2*)//;
    my $substr = $1;
    print length $substr;
    print substr $substr, 0, 1;
}

print "\n";