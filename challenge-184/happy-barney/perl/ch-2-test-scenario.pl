
use strict;
use warnings;

use Test::YAFT;

act { [ challenge_184_2 (@{ $_[0] }) ] } 'list_of_strings';

it q[should pick numbers and letters from strings]
	=> with_list_of_strings => [
		'a 1 b', '2 c 3',
	]
	=> expect => [
		[
			qw[ 1 ],
			qw[ 2 3 ],
		],
		[
			qw[ a b ],
			qw[ c ],
		],
	]
	;

it q[should omit result when string contains only letters or numbers]
	=> with_list_of_strings => [
		'a 1 b', '1 2 3', '2 c 3', 'a b c', '4 d',
	]
	=> expect => [
		[
			qw[ 1 ],
			qw[ 1 2 3 ],
			qw[ 2 3 ],
			qw[ 4 ],
		],
		[
			qw[ a b ],
			qw[ c ],
			qw[ a b c ],
			qw[ d ],
		],
	]
	;

it q[should recognize single char strings]
	=> with_list_of_strings => [
		'a', '1',
	]
	=> expect => [
		[
			qw[ 1 ],
		],
		[
			qw[ a ],
		],
	]
	;

it 'should accept empty list'
	=> with_list_of_strings => [
	]
	=> expect => [
		[],
		[],
	]
	;

had_no_warnings;
done_testing;

