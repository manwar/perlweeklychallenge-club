#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

my @examples = (
    {
        in  => "aeiou",
        out => [ "aeiou" ]
    },
    {
        in  => "aaeeeiioouu",
        out => [ "aaeeeiioou", "aaeeeiioouu", "aeeeiioou", "aeeeiioouu" ]
    },
    {
        in  => "aeiouuaxaeiou",
        out => [ "aeiou", "aeiouu", "aeiouua", "eiouua", "aeiou" ]
    },
    {
        in  => "uaeiou",
        out => [ "uaeio", "uaeiou", "aeiou" ]
    },
    {
        in  => "aeioaeioa",
        out => []
    },
);

is_deeply count_vowel($_->{in}), $_->{out} foreach @examples;

done_testing;

sub count_vowel {
    my ($str) = @_;

    my @count;
    my $len = length($str);

    for my $start (0 .. $len - 1) {
        for my $length (5 .. $len - $start) {
            my $sub = substr($str, $start, $length);
            next unless $sub =~ /^[aeiou]+$/;
            next unless $sub =~ /a/ && $sub =~ /e/ && $sub =~ /i/ && $sub =~ /o/ && $sub =~ /u/;
            push @count, $sub;
        }
    }

    return \@count;
}
