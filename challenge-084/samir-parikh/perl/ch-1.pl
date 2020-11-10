#!/usr/local/bin/perl

use warnings;
use strict;

chomp(my $number = <STDIN>);

die "Not an integer" unless $number =~ /^[+-]?\d+\z/;

if ($number > 2147483647 || $number < -2147483647) {
    print "0\n";
} else {
    if ($number < 0) {
        $number = $number * -1;
        print "-", scalar reverse($number), "\n";
    } else {
        print scalar reverse($number), "\n";
    }
}
