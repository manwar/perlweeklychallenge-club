#!/usr/bin/env perl

# Perl Weekly Challenge 327 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-327/

use Modern::Perl;
use List::Util qw(min);

@ARGV or die "usage: $0 nums...\n";

my @nums = @ARGV;
my $mad = get_mad(@nums);
my @pairs = get_pairs($mad, @nums);
say join ", ", map {"[$_]"} map {join ",", @$_} @pairs;

sub get_mad {
    my(@nums) = @_;
    @nums = sort {$a<=>$b} @nums;
    my $mad = 1e10;
    for my $i (0 .. $#nums-1) {
        $mad = min($mad, abs($nums[$i]-$nums[$i+1]));
    }
    return $mad;
}

sub get_pairs {
    my($mad, @nums) = @_;
    @nums = sort {$a<=>$b} @nums;
    my @pairs;
    for my $i (0 .. $#nums-1) {
        if ($mad == abs($nums[$i]-$nums[$i+1])) {
            push @pairs, [$nums[$i], $nums[$i+1]];
        }
    }
    return @pairs;
}
