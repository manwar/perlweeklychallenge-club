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

sub unique {
    my ($arr) = @_;
    my %unique;
    for my $elem (@{$arr}) {
        $unique{$elem}++;
    }

    return keys %unique;
}

my $word = shift;

my @permutations;
permute { push @permutations, \@_; } (split //, $word);

my %rank;
my $index = 1;
for my $perm (sort (unique([map { join q{}, @{$_} } @permutations]))) {
    $rank{$perm} = $index++;
}

say $rank{$word};
