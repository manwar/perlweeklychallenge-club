#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';
use DateTime;
sub mirror_dates ($birth_date) {
   my %bd;
   @bd{qw< year month day >} = split m{\D+}mxs, $birth_date;
   $birth_date = DateTime->new(%bd, hour => 12, minute => 0, second => 0);
   my $today = DateTime->now;
   my $delta = $today->delta_days($birth_date);
   return (
      $birth_date->subtract_duration($delta)->ymd('/'),
      $today->add_duration($delta)->ymd('/'),
   );
}
say join ', ', mirror_dates(shift // '1967-02-14');
