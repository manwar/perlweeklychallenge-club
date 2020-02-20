#!/usr/bin/env perl6

use v6;

sub MAIN() {

    my $fmt  = { sprintf "%02d%02d%04d", .month, .day, .year };
    my $date = Date.new(2000, 1, 1, formatter => $fmt);
    while ($date.year <= 2999) {
        my $date_as_str = $date.Str;
        if $date_as_str eq $date_as_str.flip {
            say "$date_as_str is a Palindrome date.";
        }
        $date = $date.later(days => 1);
    }
}
