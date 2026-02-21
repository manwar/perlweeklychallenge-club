#!/usr/bin/env perl

use Modern::Perl;
use List::Util 'sum';

say group_sum(@ARGV);

sub group_sum {
    my($str, $n) = @_;

    while (length($str) > $n) {
        my $new = "";
        while ($str ne "") {
            my $digits = substr($str, 0, $n);
            $str = length($str) > $n ? substr($str, $n) : "";
            my $sum = sum(split //, $digits);
            $new .= $sum;
        }
        $str = $new;
    }
    return $str;
}
