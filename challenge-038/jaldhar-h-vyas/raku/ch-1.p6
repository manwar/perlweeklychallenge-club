#!/usr/bin/perl6

grammar Date {
    token TOP {
        ^ <year> <month> <day> $
    }

    token year {
        <century> $<shortyear> = <[0 .. 9]> ** 2
    }

    token century {
        <[ 12 ]>
    }

    token month {
        0 <[1 .. 9]> || 1 <[0 .. 2]>
    }

    token day {
        0 <[1 .. 9]> || <[1 .. 2]> <[0 .. 9]> || 3 <[0 .. 1]>
    }
}

class DateAction {
    method TOP($/) {
        if self!isValidDate($/<year>.made.Int, $/<month>.Int, $/<day>.Int) {
            make ($/<year>.made, $/<month>, $/<day>).join(q{-});
        }
    }

    method year($/) {
        make ($/<century> == 1 ?? 20 !! 19) ~ $/<shortyear>;
    }

    method !isLeap(Int $year) {
        return $year %% 4 && ($year !%% 100 || $year %% 400);
    }

    method !isValidDate(Int $year, Int $month, Int $day) {
        if $month == 2 && $day > (self!isLeap($year) ?? 29 !! 28) {
            return False;
        }

        if ($month == any ( 4, 6, 9, 11 )) && $day > 30 {
            return False;
        }

        return True;
    }
}

multi sub MAIN(Str $input) {
    my $date = Date.parse($input, actions => DateAction.new);
    say $date && $date.made ?? $date.made !! 'Invalid date.';
}
