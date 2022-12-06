#!/usr/bin/perl
# ch-2.pl
#
# You are given a string made of alphabetic characters only, a-z.
# Write a script to determine whether removing only one character can make the frequency of the remaining characters the same.

use warnings;
use strict;

my @strings = (
    "abbc",
    "xyzyyxz",
    "xzxz"
);

foreach my $string (@strings) {
    my $output = calculate($string);
    print "$string -> $output\n";
}

sub calculate {
    my $string = shift;
    my @parts = split //, $string;
    my $map = {};
    my $reverse_map = {};
    # map will contain the frequency of each character
    map { $map->{$_}++ } @parts;
    # let's count all frequencies
    foreach my $key (keys %$map) {
        $reverse_map->{ $map->{$key} }//=0;
        $reverse_map->{ $map->{$key} }++;
    }
    # if we have more or less than 2 frequencies then
    # removing one character won't end up in the same
    # frequency for all characters
    if(scalar(keys(%$reverse_map)) != 2) {
        return 0;
    }
    # let's sort the different frequencies
    my ($first, $second) = sort {$a <=> $b} keys %$reverse_map;
    return 1 if $first+1 == $second && $reverse_map->{$second} == 1;
    return 0;
}
