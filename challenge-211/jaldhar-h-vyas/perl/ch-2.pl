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

sub sum {
    my ($arr) = @_;
    my $total = 0;

    for my $elem (@{$arr}) {
        $total += $elem;
    }

    return $total;
}

sub average {
    my ($nums) = @_;

    return sum($nums) / scalar @{$nums};
}

my @permutations;
permute { push @permutations, \@_; } @ARGV;

my @nums;
for my $i (@permutations) {

    for my $j (1 .. scalar @{$i} - 1) {
        my @array = @{$i};
        my @part1 = splice(@array, 0, $j);
        my @part2 = @array;

        if (average([@part1]) == average([@part2])) {
            say "true";
            exit;
        }
    }
}
say 'false';
