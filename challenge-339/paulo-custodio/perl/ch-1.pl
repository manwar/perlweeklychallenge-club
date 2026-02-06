#!/usr/bin/env perl

use Modern::Perl;
use List::Util qw(max);

@ARGV or die "usage: $0 nums..\n";
say max_diff(@ARGV);

sub max_diff {
    my(@nums) = @ARGV;
    return 0 if @nums < 4;

    my $max_diff = -1e10;
    my $check_pairs = sub {
        my($a, $b, $c, $d) = @_;
        my $diff1 = $a*$b-$c*$d;
        my $diff2 = $c*$d-$a*$b;
        $max_diff = max($max_diff, $diff1, $diff2);
    };

    for my $i (0 .. $#nums - 3) {
        for my $j ($i + 1 .. $#nums - 2) {
            for my $k ($j + 1 .. $#nums - 1) {
                for my $l ($k + 1 .. $#nums) {
                    # We have 4 distinct elements: $nums[$i], $nums[$j], $nums[$k], $nums[$l]
                    # There are exactly 3 ways to split these into 2 disjoint pairs:
                    $check_pairs->($nums[$i], $nums[$j], $nums[$k], $nums[$l]);
                    $check_pairs->($nums[$i], $nums[$k], $nums[$j], $nums[$l]);
                    $check_pairs->($nums[$i], $nums[$l], $nums[$j], $nums[$k]);
                }
            }
        }
    }

    return $max_diff;
}
