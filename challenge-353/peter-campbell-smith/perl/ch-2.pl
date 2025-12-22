#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-12-22
use utf8;     # Week 353 - task 2 - Validate coupon
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

validate_coupon(['A123', 'B_456', 'C789', 'D@1', 'E123'],
	['electronics', 'restaurant', 'electronics', 'pharmacy', 'grocery'],
	['true', 'false', 'true', 'true', 'true']);
validate_coupon(['Z_9', 'AB_12', 'G01', 'X99', 'test'],
    ['pharmacy', 'electronics', 'grocery', 'electronics', 'unknown'],
    ['true', 'true', 'false', 'true', 'true']);
validate_coupon(['_123', '123', '', 'Coupon_A', 'Alpha'],
    ['restaurant', 'electronics', 'electronics', 'pharmacy', 'grocery'],
    ['true', 'true', 'false', 'true', 'true']);
validate_coupon(['ITEM_1', 'ITEM_2', 'ITEM_3', 'ITEM_4'],
    ['electronics', 'electronics', 'grocery', 'grocery'],
    ['true', 'true', 'true', 'true']);
validate_coupon(['CAFE_X', 'ELEC_100', 'FOOD_1', 'DRUG_A', 'ELEC_99'],
    ['restaurant', 'electronics', 'grocery', 'pharmacy', 'electronics'],
    ['true', 'true', 'true', 'true', 'false']);

sub validate_coupon {
	
	my ($codes, $names, $status, $result, %good);
	
	# initialise
	($codes, $names, $status) = @_;
	%good = (electronics => 1, restaurant => 1, electronics => 1, pharmacy => 1, grocery => 1);
	
	# apply conditions
	$result .= ($status->[$_] eq 'true'
		and $good{$names->[$_]}
		and $codes->[$_] =~ m|^[a-z0-9_]+$|i) ? 'true, ' : 'false, '
		for (0 .. scalar @$codes - 1);
	
	# report
	say qq[\nInput:  \@codes  = ('] . join(q[', '], @$codes) . qq[')\n] .
		qq[        \@names  = ('] . join(q[', '], @$names) . qq[')\n] .
		qq[        \@status = ('] . join(q[', '], @$status) . q[')];
	say qq[Output: ] . substr($result, 0, -2);
}
