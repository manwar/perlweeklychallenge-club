#!/usr/bin/perl
use 5.030;
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

my @nums = @ARGV;

my $maxGreatness = 0;

my @permutations;
permute { push @permutations, \@_; } @nums;

for my $perm (@permutations) {
    my $greatness = 0;
 
    for my $i (0 .. scalar @{$perm} - 1) {
        if ($nums[$i] < $perm->[$i]) {
            $greatness++;
        }
    }

    if ($greatness > $maxGreatness) {
        $maxGreatness = $greatness;
    }
}

say $maxGreatness;
