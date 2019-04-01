#!/usr/bin/env perl

use 5.026;
use strict;
use integer;
use warnings;

my $usage = "Usage: $0 FROM_BASE TO_BASE NUMBER\n\nError";

die "$usage: invalid number of arguments\n"
    unless @ARGV == 3;

my @digits = ('0' .. '9', 'A' .. 'Z');
my %digits = map {$digits[$_] => $_} 0 .. @digits-1;

my ($from_base, $to_base, $number) = @ARGV;

die "$usage: FROM_BASE must be between 2 and @digits\n"
    if $from_base < 2 || $from_base > @digits;

die "$usage: TO_BASE must be between 2 and @digits\n"
    if $to_base < 2 || $to_base > @digits;

sub from_base {
    my ($base, $string) = @_;
    my $n = 0;
    $string =~ s/^0+//;
    foreach my $char (reverse split //, $string) {
        die "$usage: Invalid char in NUMBER: '$char'\n"
            if $digits{$char} >= $base;
        $n *= $base;
        $n += $digits{$char};
    }
    return $n;
}

sub to_base {
    my ($base, $n) = @_;
    my $string = '';
    for (my $i = $n; $i; $i /= $base) {
        $string .= $digits[$i % $base];
    }
    return length $string ? reverse $string : '0';
}

say to_base($to_base, from_base($from_base, $number));
