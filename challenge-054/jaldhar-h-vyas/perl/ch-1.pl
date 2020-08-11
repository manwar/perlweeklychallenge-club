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

my ($n, $k) = @ARGV;

my @permutations;
permute { push @permutations, \@_; } (1 .. $n);
say join q{}, @{ $permutations[$k - 1] };