unit class Date::WDOM is Date is export;

multi method new(:$weekday-of-month!, :$day-of-week!, :$month!, :$year! where $weekday-of-month eq 'L'|'Last')
{
    my $dt = Date.new(:$year, :$month).last-date-in-month;
    my $d = $dt.day-of-week - $day-of-week;
    $dt - ($d >= 0 ?? $d !! 7 + $d);
}

multi method new(:$weekday-of-month!, :$day-of-week!, :$month!, :$year! where $weekday-of-month ~~ 1..4) 
{
    my $dt = Date.new(:$year, :$month); 
    my $wdom = $day-of-week >= $dt.day-of-week ?? $weekday-of-month - 1  
                                               !! $weekday-of-month; 
    $dt += 7 * $wdom + $day-of-week - $dt.day-of-week; 
}

multi method new(:$weekday-of-month!, :$day-of-week!, :$month!, :$year! where $weekday-of-month == 5)
{
    my $dt = Date.new(:$year, :$month).last-date-in-month;
    my $d = $dt.day-of-week - $day-of-week;
    $dt -= $d >= 0 ?? $d !! 7 + $d;

    return $dt if $dt.day == 29|30|31;

    # Todo: handle the exception here.
    die "There is no fifth day-of-week == $day-of-week in $month/$year"; 
}
