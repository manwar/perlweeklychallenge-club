#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-05-26
use utf8;     # Week 323 - task 2 - Tax amount
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

tax_amount(10, [[3, 50], [7, 10], [12, 25]]);
tax_amount(2, [[1, 0], [4, 25], [5,50]]);
tax_amount(0, [[2, 50]]);

# UK 2025/6 tax rates
tax_amount(80000, [[12570, 0], [50270, 20], [125140, 40], [1e10, 45]]);
tax_amount(150000, [[12570, 0], [50270, 20], [125140, 40], [1e10, 45]]);

sub tax_amount {
	
	my ($income, $tax_rates, $tax, $band_start, $band_end, $band, $rate, $rates, $taxable, $explain);
	
	# initialise
	($income, $tax_rates) = @_;
	$tax = 0;
	$explain = '';
	
	# loop over tax bands
	$band_start = 0;
	for $band (@$tax_rates) {
		($band_end, $rate) = @$band;
		$rates .= qq[up to $band_end at $rate%, ];
		next if $income <= $band_start;
		
		# tax payable in this band
		$taxable = $income > $band_end ? ($band_end - $band_start) : ($income - $band_start);
		$tax += $taxable * $rate / 100;
		$explain .= qq[$taxable at $rate%, ];
		$band_start = $band_end;
	}
		
	say qq[\nInput:  \$income = $income, \@tax = (] . substr($rates, 0, -2) . q[)];
	say qq[Output: \$tax = ] . sprintf('%.2f', $tax) . 
		($tax ? ' being '. substr($explain, 0, -2) : '');
}
