sub chowla {
    my ($n) = @_;
    my $sum = 0;
    for my $i (2 .. sqrt($n)) {
        if ($n % $i == 0) {
            $sum += $i;
            $sum += $n/$i unless $i == $n/$i;
        }
    }
    return $sum;
}

for my $n (1 .. 20) {
    print chowla($n), "\n";
}

