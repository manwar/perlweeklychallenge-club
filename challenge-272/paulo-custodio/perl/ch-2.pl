#!/usr/bin/env perl

use Modern::Perl;

say score(shift // "");

sub score {
    my($str) = @_;
    my @chars = map {ord} split //, $str;
    my $score = 0;
    for (0 .. $#chars-1) {
        $score += abs($chars[$_+1] - $chars[$_]);
    }
    return $score;
}
