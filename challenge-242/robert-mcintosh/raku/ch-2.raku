sub exchange($number) {
    if $number == 0 {
        return 1
    }
    return 0;
}

sub flip-matrix(@matrix) {
    my @flipped-matrix;
    for @matrix -> $row {
        my @reversed-row = $row.reverse;
        my @exchanged-row = map &exchange, @reversed-row;
        @flipped-matrix.push(@exchanged-row);
    }
    return @flipped-matrix;
}
