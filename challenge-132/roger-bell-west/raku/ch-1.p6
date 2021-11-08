#! /usr/bin/perl6

use Test;

plan 3;

is-deeply(mirdat(
  [2021,9,18],[2021,9,22]
    ),
          [[2021,9,14],[2021,9,26]],
          'example 1'
            );

is-deeply(mirdat(
  [1975,10,10],[2021,9,22]
    ),
          [[1929,10,27],[2067,9,5]],
          'example 2'
            );

is-deeply(mirdat(
  [1967,2,14],[2021,9,22]
    ),
          [[1912,7,8],[2076,4,30]],
          'example 3'
            );

sub mirdat(@then,@now) {
  my $thent=Date.new(@then[0],@then[1],@then[2]);
  my $nowt;
  if (@now[0]==0) {
    $nowt=Date.today;
  } else {
    $nowt=Date.new(@now[0],@now[1],@now[2]);
  }
  my $delta=$nowt.daycount-$thent.daycount;
  my @o;
  for $thent.earlier(day => $delta),$nowt.later(day => $delta) -> $targett {
    push @o,[$targett.year,$targett.month,$targett.day];
  }
  return @o;
}
