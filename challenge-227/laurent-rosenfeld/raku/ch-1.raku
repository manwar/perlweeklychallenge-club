sub friday_13 ($y) {
    my $count = 0;
    for 1..12 -> $m {
        # For the Raku Date class, Friday is the
        # 5th day of the week
        $count++ if Date.new($y, $m, 13).day-of-week == 5;
    }
    return $count;
}
for 1753, |(2023..2030), 9998 -> $year {
    say $year, " => ", friday_13 $year;
}
