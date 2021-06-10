#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 11301.pl
#
#        USAGE: ./11301.pl SUM DIGIT
#
#  DESCRIPTION: Report if SUM can be a sum of natural numbers each of
#               which includes DIGIT at least once
#
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 17/05/21
#===============================================================================

use strict;
use warnings;

my ($sum, $d) = @ARGV;
result (0) if $sum < $d;

# What is the limit? ie. there must be a number beyond which the sum is
# always possible, but what is that?
# If $d is 1 then it's always true.
# If $d is 2 then every $sum above 19 is true because it is either 20 +
# x * $d or 21 + x * $d.
# If $d is 3 then every $sum above 29 is true because it is either 30 +
# x * $d or 31 + x * $d or 22 + x * $d.
# So, by inspection if $d = 9 The biggest number which cannot be summed
# to is 80?
#
# Upshot: we don't need to worry about computing massive sums. Phew.
#
# What about 01? does that contain a zero? Let's say yes.
result (1) if ($sum > 80);

# Everything in between
my @components;
for my $n ($d .. $sum) {
	next unless $n; # Adding zero is a no-op
	unshift @components, $n if $n =~ /$d/;
}

# Now, try subtracting a number from the total and see if you can fit
# the rest. Recursion!
result (sum_fit ($sum, @components));

sub sum_fit {
	my ($target, @comps) = @_;
	return 0 if $target < 0;
	for my $n (@comps) {
		my $newtarget = $target - $n;
		return 1 if $newtarget == 0 || sum_fit ($newtarget, @comps);
	}
	return 0;
}

sub result {
	print "$_[0]\n";
	exit;
}
