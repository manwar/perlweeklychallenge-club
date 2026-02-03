#!/usr/bin/env perl

use Modern::Perl;
use List::Util qw(sum);

@ARGV or die "usage: $0 scores...\n";
say calc_score(@ARGV);

sub calc_score {
    my(@ops) = @_;
    my @scores = (0, 0);    # so that + is safe
    for (@ops) {
        /^-?\d+$/ and do { push @scores, $_; next; };
        /^\+$/ and do { push @scores, $scores[-1]+$scores[-2]; next; };
        /^C$/ and do { pop @scores; unshift @scores, 0; next; };
        /^D$/ and do { push @scores, 2*$scores[-1]; next; };
        die "invalid op: $_";
    }
    return sum(@scores);
}
