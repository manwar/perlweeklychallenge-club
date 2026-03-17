#!/usr/bin/env perl

# Perl Weekly Challenge 298 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-298/

use Modern::Perl;

@ARGV or die "usage: $0 'n n' 'n n'...\n";
my @int = map {[split ' ', $_]} @ARGV;
my @right_int = right_int(@int);
say "(", join(", ", @right_int), ")";

sub right_int {
    my(@int) = @_;
    my @right_int;
    for my $i (0 .. $#int) {
        my @candidates;
        for my $j (0 .. $#int) {
            push @candidates, [$j, @{$int[$j]}] if $int[$j][0] >= $int[$i][1];
        }
        if (@candidates) {
            @candidates = sort {$a->[1] <=> $b->[1]} @candidates;
            push @right_int, $candidates[0][0];
        }
        else {
            push @right_int, -1;
        }
    }
    return @right_int;
}
