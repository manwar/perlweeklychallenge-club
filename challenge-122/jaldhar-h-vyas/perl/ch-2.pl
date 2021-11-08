#!/usr/bin/perl
use 5.020;
use warnings;

sub arrange {
    my ($ones, $twos, $threes) = @_;
    my @arranged;

    if ($ones) {
        push @arranged, (split //, ('1' x $ones));
    }

    if ($twos) {
        push @arranged, (split //, ('2' x $twos));
    }

    if ($threes) {
        push @arranged, (split //, ('3' x $threes));
    }

    return @arranged;
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

my $S = shift // die "Need score as an integer.\n";
my %scores;

for  my $threes (0 .. $S / 3) {
    my $remainder = $S - $threes * 3;
    for my $twos (0 ..  $remainder / 2) {
        my $ones = $remainder - $twos * 2;

        my @permutations;
        permute { push @permutations, \@_; }
            arrange($ones, $twos, $threes);

        for my $perm (@permutations) {
            $scores{join q{}, @{$perm}}++;
        }
    }
}

for my $score (sort keys %scores) {
    say join q{ }, (split //, $score);
}
