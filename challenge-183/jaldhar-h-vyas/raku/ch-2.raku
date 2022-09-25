#!/usr/bin/raku


sub parseDate (Str $date) {
    my ($year, $month, $day) = $date.split(q{-});

    return Date.new($year, $month, $day);
}

sub MAIN(
    Str $date1, #= date in the form YYYY-MM-DD
    Str $date2  #= date in the form YYYY-MM-DD
) {
    my $dt1 = parseDate($date1);
    my $dt2 = parseDate($date2);
    if $dt1.year > $dt2.year {
        ($dt1, $dt2) = ($dt2, $dt1);
    }
    my $days = ($dt2.daycount - $dt1.daycount).abs;
    my $years = 0;

    my $leapDays =  ($dt1.year .. $dt2.year).grep({ Date.new(year => $_).is-leap-year}).elems;
    if $dt1.is-leap-year && $dt1 > Date.new($dt1.year, 2, 29) {
        $leapDays--;
    }
    if $dt2.is-leap-year && $dt2 < Date.new($dt2.year, 2, 29) {
        $leapDays--;
    }
    $days -= $leapDays;

    if $days >= 365 {
        $years = $days div 365;
        $days %= 365;
    }

    my @output;
    if $years {
        @output.push( $years,  'year' ~ ($years == 1 ?? q{} !! 's') );
    }
    if $days {
        @output.push( $days,  'day' ~ ($days == 1 ?? q{} !! 's') );
    }
    @output.join(q{ }).say;
}