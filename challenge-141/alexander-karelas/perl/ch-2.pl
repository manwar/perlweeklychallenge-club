#!/usr/bin/env perl

use v5.32;
use warnings;

use List::Util 'any';

use experimental 'signatures';

sub find_like ($m, $n) {
    my @digits = split //, $m;
    my $length = @digits;
    my @return;

    for (my $i = 1; $i <= 2 ** $length - 2; $i++) {
        my @onoff = split //, sprintf("%0${length}b", $i);
        my $idx = 0;
        my $candidate = join '', map {
            my $digit = $digits[$_];
            my $onoff = $onoff[$_];
            $onoff ? ($digit) : ();
        } (0 .. $length-1);
        push @return, $candidate if $candidate % $n == 0;
    }

    return sort {$a <=> $b} @return;
}

say foreach find_like(@ARGV);
