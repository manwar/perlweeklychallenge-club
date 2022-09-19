
use strict;
use warnings;

use Test::YAFT;

BEGIN {
	my $CONTRIBUTION = "./ch-2.pl";
	do $CONTRIBUTION;
}

it "should recognize single path"
	=> expect => '/usr/bin/baz'
	=> got    => challenge_182_2 [
		q[/usr/bin/baz],
	]
	;

it "should recognize tailing slash"
	=> expect => '/usr/bin/baz'
	=> got    => challenge_182_2 [
		q[/usr/bin/baz/],
		q[/usr/bin/baz],
	]
	;

it "should find common absolute path"
	=> expect => '/usr'
	=> got    => challenge_182_2 [
		q[/usr/bin/foo],
		q[/usr/lib/bar],
	]
	;

it "should handle root dir"
	=> expect => '/'
	=> got    => challenge_182_2 [
		q[/usr/bin/foo],
		q[/usr/lib/bar],
		q[/etc],
	]
	;

it "should find common relative path"
	=> expect => 'usr'
	=> got    => challenge_182_2 [
		q[usr/bin/foo],
		q[usr/lib/bar],
	]
	;

it "should recognize single path"
	=> expect => '/usr/bin/baz'
	=> got    => challenge_182_2 [
		q[/usr/bin/baz]
	]
	;

it "should recognize empty array"
	=> expect => ''
	=> got    => challenge_182_2 []
	;

had_no_warnings;
done_testing;

