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

sub sum {
    my @arr = @_;
    my $sum = 0; 
    for my $i (@arr) {
        $sum += $i;
    }

    return $sum;
}

my @permutations;
permute { push @permutations, \@_; } (1 .. 9);

for my $permutation (@permutations) {
    my @matrix = @{$permutation};

    sum( @matrix[0, 1, 2] ) == 15 || next;
    sum( @matrix[3, 4, 5] ) == 15 || next;
    sum( @matrix[6, 7, 8] ) == 15 || next;
    sum( @matrix[0, 3, 6] ) == 15 || next;
    sum( @matrix[1, 4, 7] ) == 15 || next;
    sum( @matrix[2, 5, 8] ) == 15 || next;
    sum( @matrix[0, 4, 8] ) == 15 || next;
    sum( @matrix[2, 4, 6] ) == 15 || next;

    for my $row (0 .. 2) {
        say q{[ }, (join q{ }, @matrix[$row * 3 .. $row * 3 + 2]), q{ ]};
    }

    last;
}
