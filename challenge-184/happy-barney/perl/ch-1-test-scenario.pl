
use strict;
use warnings;

use Test::YAFT;

act { [ challenge_184_1 (@{ $_[0] }) ] } 'list_of_strings';

it 'should replace leading 2 chars in every string'
	=> with_list_of_strings => [
		'aa0011', 'bb0022', 'cc0033', 'dd0044',
		'ee0055', 'ff0066', 'gg0077', 'hh0088',
		'ii0099', 'jj1100', 'kk1111', 'll1122',
	]
	=> expect => [
		'000011', '010022', '020033', '030044',
		'040055', '050066', '060077', '070088',
		'080099', '091100', '101111', '111122',
	]
	;

it 'should use different index for same prefix'
	=> with_list_of_strings => [
		'aa0011', 'aa0022', 'aa0033', 'aa0044',
	]
	=> expect => [
		'000011', '010022', '020033', '030044',
	]
	;

it 'should accept empty list'
	=> with_list_of_strings => [
	]
	=> expect => [
	]
	;

had_no_warnings;
done_testing;

