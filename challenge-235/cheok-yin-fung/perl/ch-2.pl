# The Weekly Challenge 235
# Task 2 Duplicate Zeros
use v5.30.0;
use warnings;

sub dz {
    my @ints = @_;
    my @new_ints;
    my $k = 0;
    while (scalar @new_ints < scalar @ints) {
        if ($ints[$k] == 0) {
            push @new_ints, 0, 0;
        }
        else {
            push @new_ints, $ints[$k];
        }
        $k++;
    }
    pop @new_ints if $#new_ints > $#ints;
    return [@new_ints];
}

use Test::More tests => 3;
use Test::Deep;

cmp_deeply dz(1, 0, 2, 3, 0, 4, 5, 0), [1, 0, 0, 2, 3, 0, 0, 4];
cmp_deeply dz(1, 2, 3), [1, 2, 3];
cmp_deeply dz(0, 3, 0, 4, 5), [0, 0, 3, 0, 0];

