#!/usr/bin/perl -w

use strict;
use feature 'say';
use Test::More tests => 5;

sub validate {
	my($data) = @_;
	my(@codes) = $data->{codes}->@*;
	my(@names) = $data->{names}->@*;
	my(@status) = $data->{status}->@*;
	return map {
		(
			$status[$_] eq 'true' &&
			$codes[$_] =~ /^[A-Za-z0-9_]+$/ &&
			$names[$_] =~ /^(electronics|grocery|pharmacy|restaurant)$/
		) ? 'true' : 'false'
	} (0 .. $#codes);
}


is_deeply([ validate({
	codes => [ 'A123', 'B_456', 'C789', 'D@1', 'E123' ],
	names => [ 'electronics', 'restaurant', 'electronics', 'pharmacy', 'grocery' ],
	status => [ 'true', 'false', 'true', 'true', 'true' ] }) ],
	[ 'true', 'false', 'true', 'false', 'true' ],
	"Example 1");
is_deeply([ validate({
	codes => [ 'Z_9', 'AB_12', 'G01', 'X99', 'test' ],
	names => [ 'pharmacy', 'electronics', 'grocery', 'electronics', 'unknown' ],
	status => [ 'true', 'true', 'false', 'true', 'true' ] }) ],
	[ 'true', 'true', 'false', 'true', 'false' ],
	"Example 2");
is_deeply([ validate({
	codes => [ '_123', '123', '', 'Coupon_A', 'Alpha' ],
	names => [ 'restaurant', 'electronics', 'electronics', 'pharmacy', 'grocery' ],
	status => [ 'true', 'true', 'false', 'true', 'true' ] }) ],
	[ 'true', 'true', 'false', 'true', 'true' ],
	"Example 3");
is_deeply([ validate({
	codes => [ 'ITEM_1', 'ITEM_2', 'ITEM_3', 'ITEM_4' ],
	names => [ 'electronics', 'electronics', 'grocery', 'grocery' ],
	status => [ 'true', 'true', 'true', 'true' ] }) ],
	[ 'true', 'true', 'true', 'true' ],
	"Example 4");
is_deeply([ validate({
	codes => [ 'CAFE_X', 'ELEC_100', 'FOOD_1', 'DRUG_A', 'ELEC_99' ],
	names => [ 'restaurant', 'electronics', 'grocery', 'pharmacy', 'electronics' ],
	status => [ 'true', 'true', 'true', 'true', 'false' ] }) ],
	[ 'true', 'true', 'true', 'true', 'false' ],
	"Example 5");
done_testing();

