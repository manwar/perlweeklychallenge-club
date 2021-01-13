#!/usr/bin/perl
# The Weekly Challenge 092
# Task 1 
# main idea: hash of arrays 
use strict;
use warnings;
use Data::Dumper;

sub learn_pattern {
    my %pattern;
    my $word = $_[0];
    my @alphabet = split //, $word;
    my %hash;
    my $num_of_diff_symbols = 0;
    for (0..$#alphabet) {
        if (exists $hash{$alphabet[$_]}) {
            push @{$pattern{$hash{$alphabet[$_]}}}, $_;
        } else {
            $hash{$alphabet[$_]} = $num_of_diff_symbols;
            $pattern{$num_of_diff_symbols} = [ $_ ] ;
            $num_of_diff_symbols++;

        }
    }
    return %pattern;
}

sub verify_pattern {
    my %pattern = %{$_[0]};
    my $word = $_[1];
    my @alphabet = split //, $word;
    my @char = (undef) x length $word;
    my @symbol;
    my %ehash;
    my $num_of_diff_symbols = 0;
    for my $alpha (@alphabet) {
        if (!exists $ehash{$alpha}) {
            $ehash{$alpha} = 1;
            $symbol[$num_of_diff_symbols] = $alpha;
            $num_of_diff_symbols++;
        }
    }


    for my $order (sort {$a <=> $b} keys %pattern) {
        my @p = @{$pattern{$order}};
        for (@p) {
            $char[$_] = $symbol[$order];
        }
    }

    my $word_two = join "", @char;

    return ($word eq $word_two);
}

my %h = learn_pattern($ARGV[0]);
if (verify_pattern(\%h,$ARGV[1])) {
    print 1;
} else {
    print 0;
}
print "\n";




