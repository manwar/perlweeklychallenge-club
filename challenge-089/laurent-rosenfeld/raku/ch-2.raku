use v6;
constant \SIZE = 3;
constant \MAX = SIZE - 1;
constant \SUM = (([+] 1..SIZE*SIZE)/SIZE).Int;

my ($count-perm, $count-mat) = 0, 0;

sub print-matrix (@matrix) {
    for @matrix -> @row {
        say '[', @row.fmt("%2i").join(" "), ' ]';
    }
    say " ";
}
sub col-sum (@matrix, Int $j) {
    my $sum = 0;
    $sum += @matrix[$_][$j] if defined @matrix[$_][$j] for 0..MAX;
    return $sum;
}
sub cross_sum (@matrix) {
    my $nw2se = 0;
    $nw2se += @matrix[$_][$_] for 0..MAX;
    my $ne2sw = 0;
    $ne2sw += @matrix[$_][MAX-$_] for 0..MAX;
    return $nw2se, $ne2sw;
}
sub is-valid (@matrix) {
    for (0..MAX) -> $k {
        return False if (col-sum @matrix, $k) != SUM;
    }
    return True if SUM == all cross_sum @matrix;
    return False;
}

sub find-matrices {
    my @int-list = 1..9;
    OUT: for @int-list.permutations -> $perm {
        $count-perm++;
        my @matrix = gather {
            for $perm.Array -> $i, $j, $k {
                next OUT unless $i + $j + $k == SUM;
                take [ $i, $j, $k ];
            }
        }
        $count-mat++;
        next unless is-valid @matrix;
        print-matrix @matrix;
        # last;
    }
}

find-matrices;
say "Counters: $count-perm $count-mat";
