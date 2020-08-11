#!/usr/bin/perl

use strict;
use warnings;

my @lines	= @ARGV ? <> : <DATA>;

count_chars(@lines);
# count_chars_a_z(@lines);

# list counts of characters found
sub count_chars {
	my %list;
	my @lines	= @_;
	for ( grep { /[a-zA-Z]/ } map { split "" => $_ } @lines ) {
		$list{lc $_}++;
	}
	print "Found characters:\n";
	for (sort keys %list) {
		printf "%s: %d\n", $_, $list{$_};
	}
	print "\n---\n";
}

# list counts of every character from a to z
sub count_chars_a_z {
	my %list;
	my @lines	= @_;
	for ( grep { /[a-zA-Z]/ } map { split "" => $_ } @lines ) {
		$list{lc $_}++;
	}
	print "All characters (a-z):\n";
	for ('a'..'z') {
		printf "%s: %d\n", $_, $list{$_} || 0;
	}
	print "\n---\n";
}

__DATA__
Dictumst congue ipsum porttitor pharetra netus condimentum
adipiscing felis, suscipit rutrum volutpat primis mattis
pellentesque lectus proin fusce, luctus et consectetur
montes rhoncus tellus justo hac, dapibus augue quis.


