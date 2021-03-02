#!/usr/bin/perl
use 5.020;
use warnings;

sub factors {
    my ($size) = @_;

    my @tightest = ($size, 1);
    my $minimum =  abs($tightest[0] - $tightest[1]);

    for my $m (grep { $size % $_ == 0; } 2 .. $size / 2) {
        my $n = $size / $m;
        my $difference = abs($m - $n);
        if ($difference < $minimum) {
            $minimum = $difference;
            @tightest = ($m, $n);
        }
    }

    return @tightest;
}

sub spiral {
    my ($a, $m, $n) = @_;

    my $top = 0;
    my $bottom = $m - 1;
    my $left = 0;
    my $right = $n - 1;
    my $index = 0;
    my @matrix;

    while (1) {
        if ($left > $right) {
            last;
        }

        for (my $i = $left; $i <= $right; $i++) {
            $matrix[$bottom][$i] = $a->[$index++];
        }
        $bottom--;
 
        if ($top > $bottom) {
            last;
        }

        for (my $i = $bottom; $i >= $top; $i--) {
            $matrix[$i][$right] = $a->[$index++];
        }
        $right--;
 
        if ($left > $right) {
            last;
        }

        for (my $i = $right; $i >= $left; $i--) {
            $matrix[$top][$i] = $a->[$index++];
        }
        $top++;
 
        if ($top > $bottom) {
            last;
        }

        for (my $i = $top; $i <= $bottom; $i++) {
            $matrix[$i][$left] = $a->[$index++];
        }
        $left++;
    }

    for my $i (0 .. scalar @matrix - 1) {
        for my $j (0 .. scalar @{$matrix[$i]} - 1) {
            printf '%2d ', $matrix[$i][$j] // 0;
        }
        print "\n";
    }
}

my @A = @ARGV;

my @tightest = factors(scalar @A);

spiral(\@A, $tightest[0], $tightest[1]);
