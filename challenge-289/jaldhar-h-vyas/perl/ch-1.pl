#!/usr/bin/perl
use v5.38;

sub unique(@list) {
    my %elems;
    for (@list) {
        $elems{$_}++;
    }

    return (keys %elems);
}

my @a = sort { $a <=> $b } unique(@ARGV);
say $a[-3] // $a[-1];