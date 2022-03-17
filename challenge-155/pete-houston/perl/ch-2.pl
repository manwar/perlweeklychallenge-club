#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 15502.pl
#
#        USAGE: ./15502.pl [ N ] 
#
#  DESCRIPTION: Output the Nth Pisano period
#
#      OPTIONS: If omitted, N defaults to 3
# REQUIREMENTS: Perl 5.10.0 for 'state'
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 09/03/22
#===============================================================================

use strict;
use warnings;
use feature 'state';

my $next_fib_digit = fib_digit_iterator (shift // 3);
my (@seq, $pisper);

do {
	push @seq, $next_fib_digit->();
	$pisper = pisano_period (@seq);
} until $pisper	> 0;

print "$pisper\n";

sub fib_digit_iterator {
	my $mod = shift;
	my @fib = (0, 1); # by definition
	return sub {
		my $digit = $fib[0] % $mod;
		@fib = ($fib[1], $fib[0] + $fib[1]);
		return $digit;
	}
}

sub pisano_period {
	state $min = 1;
	# split the sequence into lots of $min, if it doesn't repeat up to
	# length / 2 then update $min and return false.
	return 0 if $min > @_ / 2;
	my @f = splice @_, 0, $min;
	my @g = splice @_, 0, $min;
	if (arrdiff (\@f, \@g)) {
		$min++;
		return 0;
	}
	return $min;
}	

# A modified lift from perlfaq4 with reversed logic
# Returns 1 if the 2 arrayrefs are different, 0 otherwise
sub arrdiff {
	my ($first, $second) = @_;
	no warnings 'uninitialized';
	return 1 unless @$first == @$second;
	for my $i (0 .. $#$first) {
		return 1 if $first->[$i] ne $second->[$i];
	}
	return 0;
}
