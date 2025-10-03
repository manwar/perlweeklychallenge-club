#!/usr/bin/raku

sub MAIN(
    $start,
    $offset is copy,
    *@holidays
) {
    my $startDate = Date.new($start);
    my @bankHolidays = @holidays.map({ Date.new($_) });
    my $endDate = $startDate;

    while ($offset > 0 ) {
        $endDate += 1;
        my $dow = $endDate.day-of-week;
        if ($dow > 0 && $dow < 6 && @bankHolidays.none == $endDate) {
            $offset--;
        }
    }

    say $endDate.yyyy-mm-dd;
}