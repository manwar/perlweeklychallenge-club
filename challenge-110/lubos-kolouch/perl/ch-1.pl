#!/usr/bin/perl
use strict;
use warnings;

my $filename = 'phone_numbers.txt';

open(FH, '<', $filename) or die $!;

while (<FH>) {
    if ($_ =~ m/^(\+|\()?(\d{2,4})\)?(\s|\-)?\d{2,4}(\s|\-)?\d{2,4}(\s|\-)?\d{2,4}$/) {
        print $_;
    }
}

close(FH);

