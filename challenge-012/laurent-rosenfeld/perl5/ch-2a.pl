#!/usr/bin/perl
use strict;
use warnings;
use feature "say";
use List::Util qw/reduce/;

sub compare {
    my ($sep, $p1, $p2) = @_;
    my @path1 = split /$sep/, $p1;
    my @path2 = split /$sep/, $p2;
    my $min_length = @path1 < @path2 ? @path1 : @path2;
    for my $i (0..$min_length - 1) {
        if ($path1[$i] ne $path2[$i]) {
            return join $sep, @path1[0..$i-1];
        }
    }
    return join $sep, @path1[0..$min_length - 1];
}

die "This program needs a separator and at least 2 paths\n"
    if @ARGV < 3;
my ($separator, @paths) = @ARGV;
chomp @paths;
say reduce {compare($separator, $a, $b)} @paths;
