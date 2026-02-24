#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-02-23
use utf8;     # Week 362 - task 2 - Spellbound sorting
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;
use Lingua::EN::Numbers::Easy;

spellbound_sorting(6, 7, 8, 9, 10);
spellbound_sorting(-3, 0, 1000, 99);
spellbound_sorting(1, -2, 3, -4, 5);
spellbound_sorting(100, 1000, 1000000, 1000000000);
spellbound_sorting(0, 5, 0, 5);
spellbound_sorting(123, 10**12, -999);
spellbound_sorting(9, 99, 999, 9999);
spellbound_sorting(100123006);

sub spellbound_sorting {
	
	my (@input, @output, @words, $w, $method, $explain);
	
	# initialise
	@input = @_;
	
	# try two methods
	for $method (1 .. 2) {
		@output = ();
		$explain= '';
	
		# make array of eg 'twenty-one¦21'
		if ($method == 1) {
			$words[$_] = number_to_words1($input[$_]) . qq[ $input[$_]] for 0 .. $#input;
		} else {
			$words[$_] = number_to_words2($input[$_]) . qq[ $input[$_]] for 0 .. $#input;
		}			
		
		# sort it into alphabetical order
		@words = sort { $a cmp $b } @words;
		
		# extract numbers
		for $w (@words) {
			$w =~ m|(.*?) (-?\d+)|;
			push(@output, $2);
			$explain .= qq[$1; ];
		}
		
		# report
		say qq[\nInput:    (] . join(', ', @input) . ')' unless $method == 2;
		say qq[Output $method: (] . join(', ', @output) . ')';
		say qq[   ] . substr($explain, 0, -2);
	}
}

sub number_to_words1 {
	
	# using Lingua::EN::Numbers::Easy
	my $words = $N{$_[0]};
	$words =~ s|negative|minus|;
	return $words;
}

sub number_to_words2 {	

	# using Perl
	my ($number, $digits, $words, $j, $piece, $minus, @chunks, $three);
	@chunks = ('billion', 'million', 'thousand', '');
	
	# check for -ve number
	$number = shift;
	$minus = $number < 0;
	$number = -$number if $minus;
	
	# check for special cases
	return 'invalid' if ($number =~ m|[^\d]| or $number > 10**12);
	return 'zero' if $number == 0;
	return 'one trillion' if $number == 10**12;
	
	# make number into words 3 digits at a time
	$words = '';
	$digits = sprintf('%012d', $number);
	while ($digits =~ m|(\d\d\d)|g) {
		if ($1) {   # ie not 000
			$three = three_digits($1);
			$words .= ' and ' 
				if ($words and $chunks[0] eq '' and $1 =~ m|^0| and $three ne '');
			$words .= $three;
			
			# add 'million', 'thousand' etc
			$words .= ' ' . $chunks[0] . ' ' if $three;
			shift @chunks;
		}
	}
	
	# tidy it up
	$words =~ m|^\s*(.*?)\s*$|;
	$words = $1;
	$words =~ s|\s+| |g;
 
	return ($minus ? qq[minus $words] : $words);
}
	
sub three_digits {

	my (@digits, @tens, @teens, $hundreds, $words, $number, $tens, $units, $hyphen);
	
	# converts 3-digit number to words
	@digits = (' ', qw[one two three four five six seven eight nine]);
	@teens = qw[ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen];
	@tens = (' ', ' ', qw[twenty thirty forty fifty sixty seventy eighty ninety]);

	# hundreds
	$number = shift;
	$hundreds = int($number / 100);
	$words = $hundreds ? $digits[$hundreds] . ' hundred' : '';
	$number -= $hundreds * 100;
	
	# tens and units	
	if ($number) {
		$words = $words . ' and' if $hundreds != 0;		
		$tens = int($number / 10);
		$units = $number - 10 * $tens;
		if ($tens != 1) {
			$hyphen = ($units and $tens) ? '-' : '';
			$words = $words . ' ' . $tens[$tens] . $hyphen . $digits[$units];
		} else {
			$words = $words . ' ' . $teens[$units];
		}
	}
	
	# tidy up spaces
	$words =~ m|^\s*(.*?)\s*$|;
	$words = $1;
	$words =~ s|\s+| |g;
	return $words;
}
