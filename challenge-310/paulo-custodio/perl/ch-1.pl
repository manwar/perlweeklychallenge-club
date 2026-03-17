#!/usr/bin/env perl

# Perl Weekly Challenge 310 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-310/

use Modern::Perl;

my @lists = map {[split ' ', $_]} @ARGV;
my @common = find_common(@lists);
say "(", join(", ", @common), ")";

sub find_common {
    my(@lists) = @_;

    my %common;
    for (@lists) {
        my @list = @$_;
        my %found;
        for (@list) {
            if (!$found{$_}++) {
                $common{$_}++;
            }
        }
    }

    my @common = grep {$common{$_}==scalar(@lists)}
                 sort {$a<=>$b} keys %common;
    return @common;
}
