#!/usr/bin/env perl

# Perl Weekly Challenge 357 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-357/

use Modern::Perl;

@ARGV==1 or die "usage: $0 num\n";
my @fracts = fracts($ARGV[0]);
say join ", ", map {$_->[1]} sort {$a->[0]<=>$b->[0]} @fracts;

sub fracts {
    my($N) = @_;
    my @fracts;
    my %seen;
    for my $den (1 .. $N) {
        for my $num (1 .. $N) {
            my $value = $num/$den;
            if (!$seen{$value}++) {
                push @fracts, [$value, "$num/$den"];
            }
        }
    }
    return @fracts;
}
