#!/usr/bin/env perl

# Perl Weekly Challenge 183 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-183/

use Modern::Perl;

sub remove_dups {
    my(@a) = @_;
    my %seen;
    @a = grep {!$seen{"@$_"}++} @a;
    return @a;
}

my @in = map {[split /,/, $_]} @ARGV;
my @out = remove_dups(@in);
say "(",(join ", ", map {"[".join(",", @$_)."]"} @out),")";
