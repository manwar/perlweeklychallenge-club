#!/usr/bin/perl
use 5.40.1;
use warnings;

my ($str, $k) = @ARGV;

if ($k == 1) {
    my $smallest = $str;

    for my $i (0 .. length($str) - 1) {
        my $rotation = substr($str, $i) . substr($str, 0, $i);
        if ($rotation lt $smallest) {
            $smallest = $rotation;
        }
    }

    say $smallest;
} else {
    say join q{}, (sort split //, $str);
}