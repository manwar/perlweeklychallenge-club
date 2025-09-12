#!/usr/bin/raku

sub count(@matrix) {
    my $count = 0;

    for @matrix -> $row {
        $count += $row.grep({ $_ mod 2 }).elems;
    }

    return $count;
}

sub MAIN(
    $row,
    $col,
    *@locations
) {
    my @matrix = [0 xx $col] xx $row;

    for @locations -> $location {
        my ($r, $c) = $location.split(',')».Int;
        @matrix[$r;*]»++;
        @matrix[*;$c]»++ ;
    }

    count(@matrix).say;
}