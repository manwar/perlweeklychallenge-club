#!/usr/bin/raku

sub format($self) {
    sprintf "%04d-%02d-%02d %02d:%02d", .year, .month, .day, .hour, .minute
        given $self;
}

sub nextBusinessDay(DateTime $dt) {
    my $next = DateTime.new(
        date => $dt.Date,
        hour => 9,
        minute => 0,
        formatter => &format
    );

    if ($dt.day-of-week == 5) {
        $next = $next.later(days => 3);
    } elsif ($dt.day-of-week == 6) {
        $next = $next.later(days => 2);
    } else {
        $next = $next.later(days => 1);
    }

    return $next;
}

sub MAIN(
    Str $timestamp, #= a datetime string in the format YYYY-MM-DD HH:MM
    Real $duration #= a duration as a decimal number of hours
) {
    my ($year, $month, $day, $hour, $minute); 
    
    if $timestamp.match(/ ^ (\d ** 4) '-' (\d ** 2) '-' (\d ** 2) ' ' (\d ** 2) ':' (\d ** 2) $/) {
        ($year, $month, $day, $hour, $minute) = $/.List;
    } else {
        die "Bad timestamp format";
    }

    my $start = DateTime.new(
        year      => $year,
        month     => $month,
        day       => $day,
        hour      => $hour,
        minute    => $minute,
        formatter => &format
    );

    my $endOfDay = DateTime.new(date => $start.Date, hour => 18, minute => 0);
    my $endOfDuration = $start.clone.later(seconds => 3_600 * $duration);
    if $endOfDuration <= $endOfDay {
        say $endOfDuration;
    } else {
        my $difference = $endOfDuration - $endOfDay;
        say nextBusinessDay($start).later(seconds => $difference);
    }
}