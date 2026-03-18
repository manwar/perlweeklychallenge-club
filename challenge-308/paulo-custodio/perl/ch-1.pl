#!/usr/bin/env perl

# Perl Weekly Challenge 308 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-308/

use Modern::Perl;

my @lists = map {[split ' ', $_]} @ARGV;
say scalar(find_common(@lists));

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
                 sort {$a cmp $b} keys %common;
    return @common;
}
