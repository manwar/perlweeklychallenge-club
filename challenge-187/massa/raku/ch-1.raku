#!/usr/bin/env raku

=begin pod

Week 187:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-187

Task #1: Days Together

    Two friends, Foo and Bar gone on holidays seperately to the same city. You
    are given their schedule i.e. C<start date> and C<end date>.

    To keep the task simple, the date is in the form C<DD-MM> and all dates
    belong to the same calendar year i.e. between C<01-01> and C<31-12>. Also
    the year is C<non-leap year> and both dates are inclusive.

    Write a script to find out for the given schedule, how many days they spent
    together in the city, if at all.

=end pod

use Test;

is 4, days-together <12-01 20-01>, <15-01 18-01>;
is 0, days-together <02-03 12-03>, <13-03 14-03>;
is 2, days-together <02-03 12-03>, <11-03 15-03>;
is 4, days-together <30-03 05-04>, <28-03 02-04>;

done-testing;

my sub day-number(Str $_) {
    fail unless /(\d**2)\-(\d**2)/;
    Date.new(2001, $/[1], $/[0]) - Date.new(2001, 1, 1)
}
sub days-together(@foo, @bar) {
    my Set() $range-foo = Range.new: |(@foo.map: &day-number);
    my Set() $range-bar = Range.new: |(@bar.map: &day-number);
    elems $range-foo ∩ $range-bar
}

