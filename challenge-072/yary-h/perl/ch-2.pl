#!/usr/bin/env perl
# Run as:
# range.pl 4 10 < input.txt
# or
# range.pl 4 10 input.txt

my ($begin_line, $end_line)=splice @ARGV,0,2;

# Not using flip-flop .. want to simply exit on the end line
while (<>) {
	next if $. < $begin_line;
	print;
	exit if $. >=$end_line;
}
