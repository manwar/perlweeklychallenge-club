#!/usr/bin/env perl

use Modern::Perl;

my @ints = @ARGV;
my %count;
for (@ints) {
    $count{$_}++;
}
my($unique) = map {$_->[0]} grep {$count{$_->[0]}==1} map {[$_, $count{$_}]} @ints;
say $unique;
