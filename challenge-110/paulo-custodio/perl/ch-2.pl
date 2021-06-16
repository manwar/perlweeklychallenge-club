#!/usr/bin/env perl

# Challenge 110
#
# TASK #2 - Transpose File
# Submitted by: Mohammad S Anwar
# You are given a text file.
#
# Write a script to transpose the contents of the given file.
#
# Input File
# name,age,sex
# Mohammad,45,m
# Joe,20,m
# Julie,35,f
# Cristina,10,f
# Output:
# name,Mohammad,Joe,Julie,Cristina
# age,45,20,35,10
# sex,m,m,f,f

use Modern::Perl;
my @data;
while (<>) {
    chomp;
    push @data, [split /,/, $_];
}
for (transpose(@data)) {
    say join ',', @$_;
}

sub transpose {
    my(@in) = @_;
    my @out;
    for my $row (0..$#in) {
        for my $col (0 .. $#{$in[$row]}) {
            $out[$col] ||= [];
            $out[$col][$row] = $in[$row][$col];
        }
    }
    return @out;
}
