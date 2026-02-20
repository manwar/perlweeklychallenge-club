#!/bin/env perl

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
