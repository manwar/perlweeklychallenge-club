#!/usr/bin/perl

# Challenge 144
#
# TASK #2 > Ulam Sequence
# Submitted by: Mohammad S Anwar
# You are given two positive numbers, $u and $v.
#
# Write a script to generate Ulam Sequence having at least 10 Ulam numbers
# where $u and $v are the first 2 Ulam numbers.
#
# For more information about Ulam Sequence, please checkout the website.
#
# The standard Ulam sequence (the (1, 2)-Ulam sequence) starts with U1 = 1 and
# U2 = 2. Then for n > 2, Un is defined to be the smallest integer that is the
# sum of two distinct earlier terms in exactly one way and larger than all
# earlier terms.

use Modern::Perl;
use Math::Combinatorics;
use List::Util 'sum';

use constant NUM_TERMS => 10;

sub next_ulam {
    my(@terms) = @_;

    # get all combinations of 2 items from previous terms
    my @combin = combine(2, @terms);

    # compute sum for all combinations
    my %sums;
    for (@combin) {
        my @items = @$_;
        my $n = sum(@items);
        $sums{$n} ||= [];
        push @{$sums{$n}}, \@items;
    }

    # choose smallest sum that has only one possible combination and is larger
    # than previous ones
    for my $n (sort {$a<=>$b} keys %sums) {
        next unless $n > $terms[-1];        # item not larger than previous
        my @items = @{$sums{$n}};
        next if @items>1;                   # more than one sum
        return $n;
    }

    die "next item not foundm terms=@terms";
}

sub ulam_iter {
    my($u, $v) = @_;
    my @terms;
    return sub {
        if (@terms==0) {
            push @terms, $u;
            return $u;
        }
        elsif (@terms==1) {
            push @terms, $v;
            return $v;
        }
        else {
            my $n = next_ulam(@terms);
            push @terms, $n;
            return $n;
        }
    };
}

my($u, $v) = @ARGV;
my $it = ulam_iter($u, $v);
my @seq;
for (1..NUM_TERMS) {
    push @seq, $it->();
}

say join(", ", @seq);
