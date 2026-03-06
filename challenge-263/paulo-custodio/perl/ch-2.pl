#!/usr/bin/env perl

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
