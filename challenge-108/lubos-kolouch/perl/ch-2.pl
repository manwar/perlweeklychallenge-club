use Math::BigRat lib => 'GMP';

sub bell_number {
    my $n = shift;
    my @bell;
    $bell[0][0] = Math::BigRat->bone;
    for my $i (1 .. $n) {
        $bell[$i][0] = $bell[$i-1][$i-1];
        for my $j (1 .. $i) {
            $bell[$i][$j] = $bell[$i-1][$j-1] + $bell[$i][$j-1];
        }
    }
    return $bell[$n][0];
}

for my $n (0 .. 9) {
    print bell_number($n), "\n";
}

