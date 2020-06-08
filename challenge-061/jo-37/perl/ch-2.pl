#!/usr/bin/perl

use Test2::V0;

{
	# regex that matches and captures an octet
	my $octet = qr{
		(
			25[0-5] | 2[0-4][0-9] | 1[0-9][0-9]
			|
			[1-9][0-9]
			|
			[0-9]
		)}x;

	# four octets, i.e. an address
	my $addr = $octet x 4;

	my @result;

	# collect full address matches and
	# return an unmatchable pattern
	sub collect {
		push @result, [$1, $2, $3, $4] if pos == length;
	};

	# Regex that never matches anything, but
	# tries all address matches on the way
	my $fail_and_collect =
		qr{
			^
			$addr			# match an address
			(?{ collect })	# collect address
			(*FAIL)			# force backtracking
		}x;

	# prepare actual call and
	# return the collected result
	sub addresses {
		my $str = shift;
		@result = ();
		$str =~ /$fail_and_collect/;
		return [@result];
	}
}

my ($str, $result);
$str = '25525511135';
$result = addresses $str;
is $result, [[255, 255, 111, 35], [255, 255, 11, 135]],
	'example from challenge';

$str = '12' x 5;
$result = addresses $str;
$" = '.';
print "$str:\n";
print "@$_\n" foreach @$result;
print "\n";

done_testing;
