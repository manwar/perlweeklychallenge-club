#!/usr/bin/env perl

# Perl Weekly Challenge 242 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-242/

use Modern::Perl;

@ARGV==1 or die "usage: $0 '([a, b, c], [d, e, f], [g, h, i])'\n";
my @m = parse(shift);

# a) Reverse each row
$_ = [reverse @$_] for @m;

# b) Invert each member
for (@m) {
    for (@$_) {
        $_ = 1-$_;
    }
}

say output(@m);

sub parse {
    my($text) = @_;
    my @m;
    my @rows = split /\]\s*,\s*\[/, $text;
    for (@rows) {
        s/\D/ /g;
        my @cols = split ' ', $_;
        push @m, \@cols;
    }
    return @m;
}

sub output {
    my(@m) = @_;
    my @elems;
    for (@m) {
        push @elems, "[".join(", ", @$_)."]"
    }
    return "(".join(", ", @elems).")";
}
