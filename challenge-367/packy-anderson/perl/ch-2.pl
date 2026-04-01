#!/usr/bin/env perl
use v5.40;

sub conflict($event1, $event2) {
  substr((my $end   = $event1->[1]), 2, 1, "");
  substr((my $start = $event2->[0]), 2, 1, "");
  $end > $start ? 'True' : 'False';
}

sub quoteWrap($array) {
  join(', ', map { qq/"$_"/ } @$array)
}

sub solution($event1, $event2) {
  say 'Input: @event1 = (' . quoteWrap($event1) . ')';
  say '       @event2 = (' . quoteWrap($event2) . ')';
  say 'Output: ' . conflict($event1, $event2);
}

say "Example 1:";
solution(["10:00", "12:00"], ["11:00", "13:00"]);

say "\nExample 2:";
solution(["09:00", "10:30"], ["10:30", "12:00"]);

say "\nExample 3:";
solution(["14:00", "15:30"], ["14:30", "16:00"]);

say "\nExample 4:";
solution(["08:00", "09:00"], ["09:01", "10:00"]);

say "\nExample 5:";
solution(["23:30", "00:30"], ["00:00", "01:00"]);
