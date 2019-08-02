#!/usr/bin/env perl
# vi:et:sw=4 ts=4 ft=perl

use strict;
use warnings;
use utf8;
use feature qw(say);

# Naive and primitive approach.

die 'Required at least two strings!' if @ARGV < 2;

my %cnt = ();
foreach my $str (@ARGV) {
    my $len = length $str;
    foreach my $l (1 .. $len) {
        foreach my $o (0 .. $len - $l) {
            $cnt{substr $str, $o, $l}++;
        }
    }
}

# See https://stackoverflow.com/a/4184957
# See https://en.wikipedia.org/wiki/Schwartzian_transform
my $longest = (
    map { $_->[0] }
    sort { $b->[1] <=> $a->[1] }
    map { [ $_, length $_] }
    grep { $cnt{$_} == scalar @ARGV } keys %cnt
)[0];

say $longest;

1;

__END__

$ perl ch-1.pl ABABC BABCA ABCBA
ABC
