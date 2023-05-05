use strict;
use warnings;

sub is_safe {
    my ($cube, $x, $y, $z, $n) = @_;

    # Check row and column
    for my $i (0 .. $n-1) {
        return 0 if $cube->[$x][$i][$z] || $cube->[$i][$y][$z];
    }

    # Check all layers
    for my $i (0 .. $n-1) {
        return 0 if $cube->[$x][$y][$i];
    }

    # Check diagonals
    for my $i (0 .. $n-1) {
        for my $j (0 .. $n-1) {
            for my $k (0 .. $n-1) {
                if (($i + $j == $x + $y) || ($i + $k == $x + $z) || ($j + $k == $y + $z) ||
                    ($i - $j == $x - $y) || ($i - $k == $x - $z) || ($j - $k == $y - $z)) {
                    return 0 if $cube->[$i][$j][$k];
                }
            }
        }
    }

    return 1;
}

sub solve_n_queens_3d {
    my ($cube, $col, $n) = @_;

    return 1 if $col >= $n;

    for my $i (0 .. $n-1) {
        for my $j (0 .. $n-1) {
            if (is_safe($cube, $i, $j, $col, $n)) {
                $cube->[$i][$j][$col] = 1;
                return 1 if solve_n_queens_3d($cube, $col + 1, $n);
                $cube->[$i][$j][$col] = 0;
            }
        }
    }

    return 0;
}

sub n_queens_3d {
    my ($n) = @_;
    my $cube = [];
    for my $i (0 .. $n-1) {
        for my $j (0 .. $n-1) {
            for my $k (0 .. $n-1) {
                $cube->[$i][$j][$k] = 0;
            }
        }
    }

    if (!solve_n_queens_3d($cube, 0, $n)) {
        print "No solution exists\n";
        return;
    }

    return $cube;
}

my $n = 2;
my $solution = n_queens_3d($n);

if ($solution) {
    for my $layer (@$solution) {
        print "Layer:\n";
        for my $row (@$layer) {
            print join(" ", @$row), "\n";
        }
        print "\n";
    }
}

