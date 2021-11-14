#!/usr/bin/env raku
use v6;
sub mirror-dates ($birth-date is copy) {
   $birth-date = Date.new(|($birth-date.comb(/\d+/)));
   my $today = Date.new(DateTime.now);
   my $delta = $today - $birth-date;
   return ($birth-date - $delta, $today + $delta);
}
sub MAIN ($d = '1967/02/14') { mirror-dates($d).join(', ').put }
