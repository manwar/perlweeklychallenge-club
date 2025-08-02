#!/usr/bin/env perl
#
# You are given a line like below:
# 
# {%  id   field1="value1"    field2="value2"  field3=42 %}
# 
# Where
# 
# a) "id" can be \w+.
# b) There can be 0  or more field-value pairs.
# c) The name of the fields are \w+.
# b) The values are either number in which case we don't need double quotes or
#    string in which case we need double quotes around them.
# 
# The line parser should return structure like below:
# {
#        name => id,
#        fields => {
#            field1 => value1,
#            field2 => value2,
#            field3 => value3,
#        }
# }
# 
# It should be able to parse the following edge cases too:
# {%  youtube title="Title \"quoted\" done" %}
# and
# {%  youtube title="Title with escaped backslash \\" %}
# 
# BONUS: Extend it to be able to handle multiline tags:
# 
# {% id  filed1="value1" ... %}
# LINES
# {% endid %}
# 
# You should expect the following structure from your line parser:
# {
#        name => id,
#        fields => {
#            field1 => value1,
#            field2 => value2,
#            field3 => value3,
#        }
#        text => LINES
# }
# 

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
	q/{%  id   field1="value1"    field2="value2"  field3=42 %}/,
	q/{%  id   field1="value1"    field2="va \"xxx\" lue2"  field3=42 %}/,
	q/{%   %}/,
];

sub line_parser
{
	my $row = shift;

	my $href = {};
	
	$row =~ /\{%\s*(\w+)/;
	return undef unless $1;

    $href->{name} = $1;
	
	$row =~ s/\\"/\034/g;
	while ($row =~ /([\w\d]+)="?(\d+|[\w\034\s]+)"?/cg) {
		my $f = $1;
		my $v = $2;
        $v =~ s/\034/"/g;
		$href->{fields}->{$f} = $v;
	}

	return $href;
}

is(line_parser($cases->[0]), { name => 'id',
								   fields => {
									   field1 => 'value1',
									   field2 => 'value2',
									   field3 => 42,
								   }
							 }, 'Example 1');
is(line_parser($cases->[1]), { name => 'id',
								   fields => {
									   field1 => 'value1',
									   field2 => 'va "xxx" lue2',
									   field3 => 42,
								   }
							 }, 'Example 2');
is(line_parser($cases->[2]), undef, 'Example 3');
done_testing();

exit 0;

