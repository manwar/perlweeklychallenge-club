#!/usr/bin/env perl

# Perl Weekly Challenge 318 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-318/

use Modern::Perl;

@ARGV==1 or die "usage: $0 str";
say "(", join(", ", find_groups($ARGV[0])), ")";

sub find_groups {
    my($str) = @_;
    my @groups;
    while ($str =~ /((\w)\2{2,})/g) {
        push @groups, $1;
    }
    return @groups;
}
