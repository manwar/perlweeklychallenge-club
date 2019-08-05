#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;

sub substrings {
    my @chars = split //, shift;
    my %substr; # using a hash to remove duplicates
    for my $i (0..$#chars) {
        for my $j ($i..$#chars) {
            $substr{ join '', @chars[$i..$j] } = 1;
        }
    }
    return keys %substr;
}
my %result = map { $_ => 1} substrings shift;
for my $word (@ARGV) {
    %result = map {$_ => 1} grep $result{$_}, substrings $word;
}
my $max = 0;
for (keys %result) {
    $max = $_ if length $_ > length $max;
}
say "Largest common substring: $max";
