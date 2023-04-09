# The Weekly Challenge 211
# Task 2 Split Same Average
use v5.30.0;
use warnings;
use List::Util qw/sum/;

sub ssa {
    my @arr = @_;
    my $num = 2**$#arr;
    my $avg = sum(@arr) / (scalar @arr);
    for (1..$num) {
        my $select = sprintf("%0b", $_);
        my @push;
        for my $i (0..$#arr-1) {
            my $ch;
            $ch = substr($select, $i, 1) if length $select > $i;
            if (defined($ch) && $ch eq "1") {
                push @push, $arr[$i];
            }
        }
        return 1 if $avg == sum(@push) / (scalar @push);
    }
    return 0;
}

use Test::More tests=>4;
ok ssa(1, 2, 3, 4, 5, 6, 7, 8) == 1;
ok ssa(2,2,2) == 1;
ok ssa(1,3) == 0;
ok ssa(1,2,3) == 0;
