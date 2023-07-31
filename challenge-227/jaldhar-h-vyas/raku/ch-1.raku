#!/usr/bin/raku


sub MAIN(
    $year where { $_ >= 1753 && $_ <= 9999 } #= year between 1753 to 9999
) {
    my $count = 0;

    for 1 .. 12 -> $month {
        my $date = Date.new(year => $year, month => $month,  day => 13);
        if $date.day-of-week == 5 {
            $count++;
        }
    }

    say $count;
}