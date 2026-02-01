#!/usr/bin/perl
use 5.038;
use warnings;

my @strings = @ARGV;
my %vals;

for my $str (@strings) {
    $vals{$str} = $str =~ /^\d+$/ ? $str : length $str;
}

say 0+(sort { $a <=> $b } values %vals)[-1];
