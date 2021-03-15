#! /usr/bin/perl6

use Test;

plan 7;

is(ft('05:15 pm'),'17:15','example 1');
is(ft('05:15 pm'),'17:15','example 2');
is(ft('19:15'),'07:15 pm','example 3');
is(ft('00:00'),'12:00 am','example 4');
is(ft('12:00'),'12:00 pm','example 5');
is(ft('12:00 am'),'00:00','example 6');
is(ft('12:00 pm'),'12:00','example 7');

sub ft($in) {
  $in ~~ /(\d+)\:(\d+)\s*(<[ap]>m)?/;
  my $h=$0;
  my $t='';
  if ($2) { # 12 to 24
    if ($h==12) {
      $h=0;
    }
    if ($2 eq 'pm') {
      $h+=12;
    }
  } else { # 24 to 12
    $t=' am';
    if ($h > 11) {
      $t=' pm';
      $h-=12;
    }
    if ($h == 0) {
      $h=12;
    }
  }
  return sprintf('%02d:%02d%s',$h,$1,$t);
}
