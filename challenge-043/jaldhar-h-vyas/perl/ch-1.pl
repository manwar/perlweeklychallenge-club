#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

sub permute (&@) {
    my $code = shift;
    my @idx = 0..$#_;
    while ( $code->(@_[@idx]) ) {
        my $p = $#idx;
        --$p while $idx[$p-1] > $idx[$p];
        my $q = $p or return;
        push @idx, reverse splice @idx, $p;
        ++$q while $idx[$p-1] > $idx[$q];
        @idx[$p-1,$q]=@idx[$q,$p-1];
    }
}

my %rings = (
'Blue'         => 8,
'Yellow'       => 7,
'Green'        => 5,
'Red'          => 9,
);

my @ringSegments = (
    [qw/ Red Red-Green /],
    [qw/ Green Red-Green Green-Black /],
    [qw/ Black Green-Black Black-Yellow /],
    [qw/ Yellow Black-Yellow Yellow-Blue /],
    [qw/ Blue Yellow-Blue /],
);

my @unknowns = qw/ Black Red-Green Green-Black Black-Yellow Yellow-Blue /;
my @numbers = (1, 2, 3, 4, 6);

my @permutations;
permute { push @permutations, \@_; } @numbers;
for my $permutation (@permutations) {
    my %try = %rings;
    my $i = 0;
    map { $try{$_} = $permutation->[$i++]; } @unknowns;
    my %ringValues;
    map {$ringValues{$_->[0]} = 0; } @ringSegments;

    map {
        my $ring = $_;
        map { $ringValues{$ring->[0]} += $try{$_} } @{$ring};
    } @ringSegments;

    if (scalar (grep { $ringValues{$_} == 11 } keys %ringValues) == 5) {
        map { say "$_ = $try{$_}"; } @unknowns;
        last;
    }
};