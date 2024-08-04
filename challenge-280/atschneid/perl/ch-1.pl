use strict;
use warnings;

use v5.38;

sub twice_first( $str ) {
    my %counts;
    grep {
	# return if the count is already 1
	return $_ if $counts{ $_ };
	++$counts{ $_ }
    } ( split '', $str );
    return '';
}

my @inputs = (
    "acbddbca",
    "abccd",
    "abcdabbb",
    "abcdefg"
    );

for (@inputs) {
    say $_ . " => " . twice_first($_);
}
