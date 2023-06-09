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
    my %unique;

    for my $elem (@_) {
        $unique{$elem}++;
    }

    return keys %unique;
}

my @results;

my @permutations;
permute { push @permutations, \@_; } @ARGV;

for my $perm (@permutations) {
    my $squareful = 1;

    for my $n (1 .. scalar @{$perm} - 1) {
        my $root = sqrt($perm->[$n - 1] + $perm->[$n]);

        if ($root != int $root) {
            $squareful = undef;
            last;
        }
    }

    if ($squareful) {
        push @results, q{(} . (join q{, }, @{$perm}) . q{)};
    }
}

say join q{, }, unique(@results);
