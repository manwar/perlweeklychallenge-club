#!/usr/bin/perl
use 5.030;
use warnings;

my $maxvalue = -Inf;

for my $str (@ARGV) {
    my $value = ($str =~ /^\d+$/) ? 0 + $str : length $str;
    if ($value > $maxvalue) {
        $maxvalue = $value;
    }
}

say $maxvalue;
