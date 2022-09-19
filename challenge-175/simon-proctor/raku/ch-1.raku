#!/usr/bin/env raku

#| Print a list of the last Sunday in each month
sub MAIN(
    Int $year = Date.today().year #= Year to give last Sunday dates for 
) {
    for (1..12) -> $month {
        my $date = Date.new($year,$month,1).later( :1month).earlier(:1day);
        while ($date.day-of-week != 7) {
            $date.=earlier(:1day)
        }
        $date.say
    }
}
