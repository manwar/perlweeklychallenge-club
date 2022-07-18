#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use bigint;

use Test::More tests => 1;

is_deeply(sylvester(10),
          [
            2,
            3,
            7,
            43,
            1807,
            3263443,
            10650056950807,
            113423713055421844361000443,
            12864938683278671740537145998360961546653259485195807,
            165506647324519964198468195444439180017513152706377497841851388766535868639572406808911988131737645185443,
              ],
          'example 1');

sub sylvester($ct) {
  my @o = (2);
  foreach (2..$ct) {
    push @o,1 + ($o[-1] * ($o[-1]-1))
  }
  return \@o;
}
