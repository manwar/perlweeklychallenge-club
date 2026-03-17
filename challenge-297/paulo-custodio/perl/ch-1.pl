#!/usr/bin/env perl

# Perl Weekly Challenge 297 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-297/

use Modern::Perl;
use List::Util qw(min);

@ARGV or die "usage: $0 nums...\n";
say max_len(@ARGV);

sub max_len {
    my(@digits) = @_;
    my @zeros = grep {$_==0} @digits;
    my @ones  = grep {$_==1} @digits;
    return min(scalar(@zeros), scalar(@ones))*2;
}
