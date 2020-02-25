#!/usr/bin/perl
# Test: ./ch-1.pl
use strict;
use warnings;
use feature qw /say/;

for my $i (1..50) {
    say 'Decimal '  . $i .
        ' = Octal ' . to_octal($i);
}

sub to_octal {
    return sprintf('%o', shift);
}
