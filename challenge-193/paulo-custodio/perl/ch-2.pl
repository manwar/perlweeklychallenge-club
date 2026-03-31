#!/usr/bin/env perl

# Perl Weekly Challenge 193 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-193/

use Modern::Perl;

sub string_diff {
    my($string)=@_;
    my @values = map {ord} split //, $string;
    my @diff = map {$values[$_+1]-$values[$_]} 0..$#values-1;
    return @diff;
}

sub odd_string {
    my(@strings)=@_;
    my %diffs;
    my %strings;
    for (@strings) {
        my @diffs = string_diff($_);
        $diffs{"@diffs"}++;
        $strings{"@diffs"}=$_;
    }
    my @odd = grep {$diffs{$_}==1} keys %diffs;
    return @odd==1 ? $strings{$odd[0]} : ".";
}

@ARGV or die "usage: ch-2.pl string...\n";
my @strings=@ARGV;
say odd_string(@strings);
