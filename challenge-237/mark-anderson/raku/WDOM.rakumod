unit class WDOM is Date is export;

multi method new(:$weekday-of-month!, :$day-of-week!, :$month!, :$year! where $weekday-of-month eq 'L'|'Last')
{
    my $dt = Date.new(:$year, :$month).last-date-in-month;

    my $day = [$dt.day-6..$dt.day].rotate($day-of-week - $dt.day-of-week).tail;

    Date.new(:$year, :$month, :$day) 
}

multi method new(:$weekday-of-month!, :$day-of-week!, :$month!, :$year!) 
{
    my $dt = Date.new(:$year, :$month);

    my $day = [1..7].rotate($day-of-week - $dt.day-of-week).head;

    $day += ($weekday-of-month - 1) * 7; 

    # Todo: Handle the exception here? 
    Date.new(:$year, :$month, :$day) 
}
