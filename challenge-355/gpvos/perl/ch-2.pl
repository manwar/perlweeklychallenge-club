#!/usr/bin/perl -w

use strict;
use feature 'say';
use List::MoreUtils qw(firstidx lastidx);
use Test::More tests => 8;

sub is_mountain_array {
	my(@ints) = $_[0]->@*;
	my $i = 0;
	++$i while $i < $#ints and $ints[$i] < $ints[$i + 1];
	my $j = $#ints;
	--$j while $j > 0 and $ints[$j - 1] > $ints[$j];
	#say "$i:$j";
	return $i == $j && $i > 0 && $j < $#ints;
}

ok(! is_mountain_array([ 1, 2, 3, 4, 5 ]),		"Example 1");
ok(  is_mountain_array([ 0, 2, 4, 6, 4, 2, 0 ]),	"Example 2");
ok(! is_mountain_array([ 5, 4, 3, 2, 1 ]),		"Example 3");
ok(! is_mountain_array([ 1, 3, 5, 5, 4, 2 ]),		"Example 4");
ok(  is_mountain_array([ 1, 3, 2 ]),			"Example 5");
ok(! is_mountain_array([ ]),				"Empty array");
ok(! is_mountain_array([ 1 ]),				"1-element array");
ok(! is_mountain_array([ 1, 3 ]),			"2-element array");
done_testing();

