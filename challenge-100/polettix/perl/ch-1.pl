#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

sub fun_time ($t) {
   my ($h, $m, $ampm) = $t =~ m{\A(\d\d):(\d\d)(?:\s*(am|pm))?\z}mxs;
   ($h, $ampm) =
      ($ampm//='') eq 'pm' ? ($h < 12 ? $h + 12 : 12, ''  )
      : $ampm eq 'am'      ? ($h < 12 ? $h      : 0 , ''  )
      : $h == 0            ? (12                    , ' am')
      : $h == 12           ? (12                    , ' pm')
      : $h > 12            ? ($h - 12               , ' pm')
      :                      ($h                    , ' am');
   return sprintf "%02d:%02d%s", $h % 24, $m, $ampm;
}

say fun_time(shift || '05:15');
