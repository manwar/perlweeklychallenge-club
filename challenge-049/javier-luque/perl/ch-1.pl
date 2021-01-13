#!/usr/bin/perl
# Test: ./ch-1.pl 55
use strict;
use warnings;
use feature qw /say/;

my $number = join '', @ARGV;

unless ($number =~ /^\d*$/) {
    say "Argument: $number needs to be a number";
    exit;
}

my $i = 1;
my $new_number = $number;
while (!($new_number =~ /^[01]+$/)) {
    $new_number = $number * $i++;
}

say "Smallest multiple of $number is $new_number";
