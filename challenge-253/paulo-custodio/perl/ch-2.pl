#!/usr/bin/env perl

use Modern::Perl;
use List::Util 'sum';

my $matrix = parse_matrix("@ARGV");
say "(", join(", ",
        map {$_->[0]}
        sort {$a->[1] == $b->[1] ? $a->[0] <=> $b->[0] : $a->[1] <=> $b->[1]}
        map {[$_, sum(@{$matrix->[$_]})]} 0 .. $#$matrix), ")";

sub parse_matrix {
    my($text) = @_;
    my @lines = split(/\]\s*,/, $text);
    my $matrix = [];
    for (@lines) {
        s/^\D+//;
        my @nums = split /\D+/, $_;
        push @$matrix, \@nums;
    }
    return $matrix;
}
