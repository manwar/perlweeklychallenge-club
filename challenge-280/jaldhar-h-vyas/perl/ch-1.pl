#!/usr/bin/perl
use v5.38;

my %seen;

for (split //, shift) {
    if (exists $seen{$_}) {
        say $_;
        last;
    } else {
        $seen{$_} = 1;
    }
}