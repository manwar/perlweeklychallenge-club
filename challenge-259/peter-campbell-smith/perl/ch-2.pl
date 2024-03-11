#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-03-04
use utf8;     # Week 259 - task 2 - Line parser
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

line_parser('{% id field1="value1" field2="value2" field3=42 %}');
line_parser('% youtube title="Title \"quoted\" done" %}');
line_parser('{% youtube title="Title with escaped backslash \\\\" %}');

line_parser('{% id field1="value1" field2="value2" %}
LINES
{% endid %}');

sub line_parser {
	
	my ($input, $id, $output, $field, $value, $first, $rest);
	
	# initialise
	$input = shift;
	say qq[\nInput: ] . $input;
	
	# detach the 'bonus' part
	($input, $rest) = ($1, $2) if $input =~ m|(.*?)\n(.*)|s;
	
	# encode \x characters as ¬nn¬
	$input =~ s|\\(.)|'¬' . ord($1) . '¬'|ge;
	
	# change eg field=22 to field="22"
	$input =~ s|=(\d+)([ %])|="$1"$2|g;

	# extract id
	$input =~ m|(\w+)(.*)|;
	$id = $1;
	$input = $2;
	$output = qq[{\n    name => $id,\n    fields => {\n];
	
	# extract fields
	while ($input =~ m|([\w\d]+)\s*=\s*"([\w\d¬ ]+)"|g) {
		$field = $1;
		$value = $2;
		
		# decode ¬nn¬
		$value =~ s|¬(\d+)¬|chr($1)|ge;
		$output .= qq[        $field => $value,\n];
	}
	$output .= qq[    }\n];
	
	# extract bonus text
	if (defined $rest and $rest =~ m|(.*)\{% endid %\}|s) {
		$output .= qq[    text => $1];
	}
	$output .= qq[}\n];
	
	say qq[Output: $output];
}	
