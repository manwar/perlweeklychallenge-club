#!/usr/bin/env raku

use v6.d;

#| convert 12-hour format time to 24-hour format and vice-versa
unit sub MAIN (
    Str $time, #= time (format: 05:15pm or "05:15 pm" or 17:00)
);

grammar Time {
    token TOP { <hour> ':' <minute> ' '? <meridiem>? }
    token hour { \d ** 1..2 }
    token minute { \d ** 1..2 }
    token meridiem { ['am'|'pm'] }
}

# Match for time format.
if Time.parse($time) -> $m {
    given $m<meridiem> {
        when 'am' {
            printf "%02d:%02d\n",
            $m<hour> == 12 ?? "00" !! $m<hour>,
            $m<minute>;
        }
        when 'pm' {
            printf "%02d:%02d\n",
            $m<hour> < 12 ?? $m<hour> + 12 !! $m<hour>,
            $m<minute>;
        }
        # If neither 'am' nor 'pm' is set then $time must be in
        # 24-hour format.
        default {
            printf "%02d:%02d%s\n",
            $m<hour> == 0 ?? "12" !! $m<hour> > 12 ?? $m<hour> - 12 !! $m<hour>,
            $m<minute>, $m<hour> < 12 ?? "am" !! "pm";
        }
    }
} else {
    note "Wrong format!";
    exit 1;
}
