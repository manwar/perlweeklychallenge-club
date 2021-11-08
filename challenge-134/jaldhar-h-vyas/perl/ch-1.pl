#!/usr/bin/perl
use 5.020;
use warnings;

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

my $prefix = '102345';

my @permutations;
permute { push @permutations, \@_; } qw/ 6 7 8 9 /;
say join q{ }, sort { $a <=> $b }
     (map { "$prefix$_" } map {join q{}, @{$_}; } @permutations)[0 .. 9];
