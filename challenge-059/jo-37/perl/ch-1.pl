#!/usr/bin/perl

# expects split limit in $ARGV[0]
# expects values to build linked list from in @ARGV[1..-1]

use strict;
use warnings;

# create linked list from given array ref
sub make_list {
	my $values = shift;
	my $head = {};
	my $prev = $head;
	foreach my $val (@$values) {
		my $this;
		$this->{val} = $val;
		$prev->{next} = $this;
		$prev = $this;
	}
	return $head->{next};
}

# print linked list from given title and head ref
sub print_list {
	my ($title, $head) = @_;
	print $title, ":\t";
	for (my $this = $head; $this; $this = $this->{next}) {
		print $this->{val};
		print '->' if $this->{next};
	}
	print "\n";
}

# switch list
# limit given as 1st arg,
# linked list given by head ref in 2nd arg
# returns: ref to head of switched list
sub switch_list {
	my ($lim, $head) = @_;
	my $upper = {};
	my $uhead = $upper;
	my $lower = {};
	my $lhead = $lower;
	for (my $this = $head; $this; $this = $this->{next}) {
		if ($this->{val} < $lim) {
			$lower->{next} = $this;
			delete $upper->{next};
			$lower = $this;
		} else {
			$upper->{next} = $this;
			delete $lower->{next};
			$upper = $this;
		}
	}
	# invalidate old head ref
	undef $_[1];

	if ($lhead->{next}) {
		$lower->{next} = $uhead->{next};
		return $lhead->{next};
	} else {
		return $uhead->{next};
	}
}

# main
my $splitval = shift;
my $head = make_list \@ARGV;
print_list 'original', $head;

my $switched = switch_list $splitval, $head;
print_list 'switched', $switched;
