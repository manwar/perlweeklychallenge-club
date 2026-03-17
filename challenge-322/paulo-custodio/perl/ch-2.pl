#!/usr/bin/env perl

# Perl Weekly Challenge 322 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-322/

use Modern::Perl;
use List::Util qw(uniq);

@ARGV or die "usage $0 nums...\n";
say "(", join(", ", rank(@ARGV)), ")";

sub rank {
    my(@nums) = @_;
    my @uniq = uniq sort {$a<=>$b} @nums;
    my %rank;
    for my $i (0 .. $#uniq) {
        $rank{$uniq[$i]} = $i+1;
    }
    my @rank = map {$rank{$_}} @nums;
    return @rank;
}
