#!/usr/bin/env perl

# Perl Weekly Challenge 263 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-263/

use Modern::Perl;
use List::Util qw( uniq pairs );

my($items1, $items2) = split /,/, "@ARGV";
my @items1 = (split ' ', $items1);
my @items2 = (split ' ', $items2);

my %items;
for (pairs(@items1, @items2)) {
    my($k, $v) = @$_;
    $items{$k} += $v;
}

my @result;
for my $k (sort {$a <=> $b} keys %items) {
    push @result, "[".$k.",".$items{$k}."]";
}
say "[", join(", ", @result), "]";
