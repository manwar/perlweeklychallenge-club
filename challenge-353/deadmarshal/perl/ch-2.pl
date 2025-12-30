#!/usr/bin/env perl
use strict;
use warnings;

sub validate_coupon{
  my %valid;
  @valid{qw(electronics grocery pharmacy restaurant)} = 1;
  map {$_[0]->[$_] =~ /^[_0-9a-zA-Z]+$/ &&
	 exists $valid{$_[1]->[$_]} &&
	 $_[2]->[$_] eq 'true' ? 1 : 0} 0..$#{$_[0]}
}

printf "(%s)\n", join ',',
  validate_coupon(['A123','B_456','C789','D@1','E123'],
		  ['electronics','restaurant','electronics',
		   'pharmacy','grocery'],
		  ['true','false','true','true','true']);
printf "(%s)\n", join ',',
  validate_coupon(['Z_9','AB_12','G01','X99','test'],
		  ['pharmacy','electronics','grocery',
		   'electronics','unknown'],
		  ['true','true','false','true','true']);
printf "(%s)\n", join ',',
  validate_coupon(['_123','123','','Coupon_A','Alpha'],
		  ['restaurant','electronics','electronics',
		   'pharmacy','grocery'],
		  ['true','true','false','true','true']);
printf "(%s)\n", join ',',
  validate_coupon(['ITEM_1','ITEM_2','ITEM_3','ITEM_4'],
		  ['electronics','electronics','grocery','grocery'],
		  ['true','true','true','true']);
printf "(%s)\n", join ',',
  validate_coupon(['CAFE_X','ELEC_100','FOOD_1','DRUG_A','ELEC_99'],
		  ['restaurant','electronics','grocery',
		   'pharmacy','electronics'],
		  ['true','true','true','true','false']);

