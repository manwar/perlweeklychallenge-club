#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';

say $_, ' ', friday_13th($_) for @ARGV;

sub friday_13th ($year) {
   return scalar grep { dow($year, $_, 13) == 5 } 1 .. 12;
}

sub dow ($y, $m, $d) {
   state $calculator = $ENV{DOW_TIMEGM} ? \&dow_timegm : \&dow_algorithm;
   return $calculator->($y, $m, $d);
}

sub dow_timegm ($y, $m, $d) {
   require Time::Local;
   my $epoch = Time::Local::timegm_modern(30, 30, 12, $d, $_ - 1, $y);
   return (gmtime($epoch))[6];
}

# https://en.wikipedia.org/wiki/Determination_of_the_day_of_the_week
sub dow_algorithm ($y, $m, $d) {
   state $t = [0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4];
   use integer;
   --$y if $m < 3;
   return ($y + $y / 4 - $y / 100 + $y / 400 + $t->[$m - 1] + $d) % 7;
}
