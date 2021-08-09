#!/usr/bin/perl
use 5.020;
use warnings;
use English qw/ -no_match_vars /;

sub usage {
    print <<"-USAGE-";
Usage:
  $PROGRAM_NAME [<n> ...]

    [<n> ...]  a list of integers
-USAGE-
    exit;
}

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

scalar @ARGV || usage;

my @n = @ARGV;
my $part1 = scalar @n / 2;
my (@best1, @best2);
my $bestdiff = 'inf';

my @permutations;
permute { push @permutations, \@_; } @n;

for my $perm (@permutations) {
    my @subset1 = splice @{$perm}, 0, $part1;
    my @subset2 = @{$perm};
    my $total1 = sum \@subset1;
    my $total2 = sum \@subset2;
    my $diff =  abs($total1 - $total2);

    if ($diff < $bestdiff) {
        $bestdiff = $diff;
        @best1 = @subset1;
        @best2 = @subset2;
        if ($bestdiff == 0) {
            last;
        }
    }
}

say "Subset 1 = (", ( join q{, }, sort { $a <=> $b } @best1) , q{)};
say "Subset 2 = (", ( join q{, }, sort { $a <=> $b } @best2 ), q{)};

