#!/usr/bin/env perl6

use v6;

sub MAIN() {
    my $fmt  = { sprintf "%02d%02d%04d", .month, .day, .year };
    my $date = Date.new(2000, 1, 1, formatter => $fmt);
    while $date.year <= 2299 {
        my $date-as-str = $date.Str;
        if $date-as-str eq $date-as-str.flip {
            say "$date-as-str is a Palindrome date.";
        }
        ++$date;
    }
}
