#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is_deeply(validatecoupon(['A123', 'B_456', 'C789', 'D@1', 'E123'], ['electronics', 'restaurant', 'electronics', 'pharmacy', 'grocery'], [1, 0, 1, 1, 1]), [1, 0, 1, 0, 1], 'example 1');
is_deeply(validatecoupon(['Z_9', 'AB_12', 'G01', 'X99', 'test'], ['pharmacy', 'electronics', 'grocery', 'electronics', 'unknown'], [1, 1, 0, 1, 1]), [1, 1, 0, 1, 0], 'example 2');
is_deeply(validatecoupon(['_123', '123', '', 'Coupon_A', 'Alpha'], ['restaurant', 'electronics', 'electronics', 'pharmacy', 'grocery'], [1, 1, 0, 1, 1]), [1, 1, 0, 1, 1], 'example 3');
is_deeply(validatecoupon(['ITEM_1', 'ITEM_2', 'ITEM_3', 'ITEM_4'], ['electronics', 'electronics', 'grocery', 'grocery'], [1, 1, 1, 1]), [1, 1, 1, 1], 'example 4');
is_deeply(validatecoupon(['CAFE_X', 'ELEC_100', 'FOOD_1', 'DRUG_A', 'ELEC_99'], ['restaurant', 'electronics', 'grocery', 'pharmacy', 'electronics'], [1, 1, 1, 1, 0]), [1, 1, 1, 1, 0], 'example 5');

sub validatecoupon($codes, $names, $status) {
  my %dep = map {$_ => 1} qw(electronics grocery pharmacy restaurant);
  my @out;
  foreach my $i (0 .. $#{$codes}) {
    push @out, ($codes->[$i] =~ /^[0-9A-Za-z_]+$/ && exists $dep{$names->[$i]} && $status->[$i])?1:0;
  }
  \@out;
}
