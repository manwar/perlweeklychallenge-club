#!/usr/bin/env raku

constant SECONDS-IN-MINUTES = 60;

class Time is DateTime {
    has $.date = Date.today();
  method COERCE (Str $time, Date $date=Date.today) {
      $time
      andthen .match: / $<hour>=\d+ ":" $<minute>=\d+ /
      andthen Time.new: :$date :$<hour> :$<minute>
  }
}

sub shortest-time ( Array[Time()]() \times) {
    times
    andthen .sort.cache
    andthen |.skip, .head.later(:1day) Z- $_
    andthen .min
    andthen * / SECONDS-IN-MINUTES
}

multi MAIN (Bool :test($)!) {
    use Test;
    is shortest-time(<00:00 20:00 23:55>), 5;
    is shortest-time(<01:01 00:50 00:57>), 4;
    is shortest-time(<10:10 09:30 09:00 09:55>), 15;
    done-testing;
}

multi MAIN (*@times) {
    say shortest-time @times
}
