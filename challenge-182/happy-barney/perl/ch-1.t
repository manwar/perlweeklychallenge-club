
use strict;
use warnings;

use Test::YAFT;

BEGIN {
	my $CONTRIBUTION = "./ch-1.pl";
	do $CONTRIBUTION;
}

it "should recognize positive numbers"
	=> expect => 2
	=> got    => challenge_182_1 [ 1, 2, 3, 1, 2, 3 ]
	;

it "should recognize negative value"
	=> expect => 0
	=> got    => challenge_182_1 [ -1, -2, -3, -1, -2, -3 ]
	;

it "should recognize single number"
	=> expect => 0
	=> got    => challenge_182_1 [0]
	;

it "should recognize empty array"
	=> expect => -1
	=> got    => challenge_182_1 []
	;

had_no_warnings;
done_testing;

