#!/usr/bin/env raku

#| Display the day of the year for a given date
sub MAIN(
    Date(Str) $d #= Date string in yyyy-mm-dd format
) {
    $d.day-of-year.say;
}
