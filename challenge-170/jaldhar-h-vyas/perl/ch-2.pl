#!/usr/bin/perl
use 5.030;
use warnings;

sub kroneckerProduct {
    my @A = @{$_[0]};
    my @B = @{$_[1]};
    my @answer;

    for my $a (0 .. scalar @A - 1) {
        for my $aa (@{$A[$a]}) {
            for my $b (0 .. scalar @B - 1) {
                for my $bb (@{$B[$b]}) {
                    push @{$answer[$a * 2 + $b]}, $aa * $bb;
                }
            }
        }
    }

    return \@answer;
}

sub printMatrix {
    my @matrix =  @{$_[0]};
    for my $row (@matrix) {
        for my $col (@{$row}) {
            printf '%2d ', $col;
        }
        print "\n";
    }
}

my @A = ([1, 2],[3, 4]);
my @B = ([5, 6],[7, 8]);

say printMatrix(kroneckerProduct(\@A, \@B));

