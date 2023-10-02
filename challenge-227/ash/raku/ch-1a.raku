sub count-friday-the13s($year) {
    my $count = 0;

    for 1..12 -> $month {
        my $dt = DateTime.new(year => $year, month => $month, day => 13);
        $count++ if $dt.day-of-week == 5;
    }

    return $count;
}

say count-friday-the13s(2023);
