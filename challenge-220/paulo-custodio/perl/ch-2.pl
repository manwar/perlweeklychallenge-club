#!/usr/bin/env perl

# Perl Weekly Challenge 220 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-220/

use Modern::Perl;

my @ints = @ARGV;

my @result;
my %found;

for (permutations(@ints)) {
    my @permu = @$_;
    next if $found{"@permu"}++;
    next unless is_squareful(@permu);
    push @result, \@permu;
}

say join(", ", sort map {"(" . join(", ", @$_) . ")"} @result);

sub is_squareful {
    my(@ints) = @_;
    for (0..$#ints-1) {
        my $sum = $ints[$_]+$ints[$_+1];
        my $sq = sqrt($sum);
        return 0 unless int($sq) == $sq;
    }
    return 1;
}

sub permutations {
    my(@elems) = @_;
    return [] if @elems == 0;

    my @result;
    for my $i (0 .. $#elems) {
        my $pick = $elems[$i];
        my @sub_perm = permutations(@elems[0 .. $i-1], @elems[$i+1 .. $#elems]);
        for (@sub_perm) {
            push @result, [$pick, @$_];
        }
    }
    return @result;
}
