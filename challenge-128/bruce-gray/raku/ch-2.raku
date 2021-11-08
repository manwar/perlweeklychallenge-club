sub max_trains ( @arrivals, @departures --> Int ) {
    die if @arrivals != @departures;

    sub time_to_offset ($_) { /^(\d\d?)\:(\d\d)$/ or die; $0 * 60 + $1; }
    my @a =   @arrivals».&time_to_offset;
    my @d = @departures».&time_to_offset;

    return (@a Z.. @d).Bag.values.max;
}

my @tests =
    (
        <11:20 14:30>,
        <11:50 15:00>,
    ),
    (
        <10:20 11:00 11:10 12:20 16:20 19:00>,
        <10:30 13:20 12:40 12:50 20:20 21:20>,
    ),
;
say max_trains(|$_) for @tests;
