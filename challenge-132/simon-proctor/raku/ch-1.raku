#!/usr/bin/env raku

#| Given a date string (yyyy-mm-dd format) returns mirror dates for you for today.
sub MAIN( Date(Str) $bday ) {
    my $today = Date.today();
    my $diff = $today - $bday;
    say $bday - $diff;
    say $today + $diff;
}
