#!/usr/bin/perl

use Test2::V0;
use Benchmark qw(cmpthese timeit);

# Naming conventions:
# - The finite strings S0, S1, S2,... are named as such only if the
#   order is fixed
# - finite strings of order k are denoted as S(k)
# - the infinite sequence S(k) for k -> inf is denoted as S
# - an individual element from S at position i is denoted as SI(i).

# The first version of task #2 (generating S1000) was easy to
# solve with a one-liner:
# CORE::dump();
# When Mohammad reduced this to S30, things started to become
# interesting.  Indeed, looking at this sequence is like zooming
# into the Mandelbrot set.

# A generalized construction of S(k+l) consists of:
# taking S(k), an empty starting string and repeating 2^(l-1) times:
# - append S(k)
# - append alternating 0/1
# - append switched reversed S(k)
# - append the next single value from S starting with SI(0),
#   but omit it at the end. The required SI(i) always exists in
#   the so far generated output.
#
# This allows to build S(k+l) from S(k) for k >= 0 and l > 0
# with a single switch/reverse operation.
#
sub sn_extend {
	# first arg: ref to S(k)
	# make $_ an alias to sk
	local $_;
	*_ = shift;
	# second arg: l
	# get loop limit from l
	my $upper = int 2**(shift() - 1) - 1;

	# reversed switched S(k)
	my $rsw = reverse y/01/10/r;

	my $sl;
	for my $i (0 .. $upper) {
		$sl .= $_ . ($i % 2) . $rsw;
		$sl .= substr $sl, $i, 1 if $i < $upper;
	}
	# avoid copying the result
	\$sl;
}

# Build S(n) by repeating sn_extend() with variable parametrization.
# First arg is a subref that gives the next value for l to be used.
# Second arg is the initial loop count.
# Third arg is the desired order n.
#
# Special cases:
# - Starting with S0, then taking S(k+1) = sn_extend(S(k), 1)
#   reproduces the rule as described in the task
# - S(n) = sn_extend(S0, n) is a single-stepping, element-wise
#   construction of S(n)
# - Starting with S1, then taking S(2*k) = sn_extend(S(k), k)
#   grows very fast and takes only a few reverse/switch operations.
#   
sub sn_build (&$$) {
	# first arg: subref returning next order step, with $_ set
	# to the current step
	my $iterate = shift;
	# second arg: start order for sn_extend
	local $_ = shift;
	# third arg: desired order n for building S(n)
	my $n = shift;

	# perform parametrized extension of S(k) -> S(k+l)
	# until the next step would exceed the target order
	my ($cum, $next, $s) = (0, $iterate->(), \'');
	while ($cum + $_ <= $n) {
		$s = sn_extend($s, $_);
		$cum += $_;
		$_ = $next;
		$next =  $iterate->();
	}

	# get missing part of S(n) if necessary and dereference the result
	$cum == $n ? $$s : ${sn_extend $s, $n - $cum}
}

# Benchmarks are disabled by default
SKIP:  {
	skip "benchmarks";
	for my $n (5, 10, 15, 20) {
		# It turns out that the doubling rule outperforms
		# the others by increasing magnitude and the single-steping
		# iterator lags behind when n > 5.
		print "\nn=$n\n";
		cmpthese(-1, {
				std     => sub {sn_build {1} 1, $n},
				double  => sub {sn_build {2 * $_} 1, $n},
				single => sub {sn_build {0} $n + 1, $n},
			});
	}
}

# get S(n) from standard rule
my @S = map {sn_build {1} 1, $_} (0 .. 5);

is $S[5], '0010011000110110001001110011011', 'S5';

# shortcut for the superiour doubling rule
sub sn {
	sn_build {2 * $_} 1, shift;
}

# check alternative building rules
for (1 .. 5) {
	is sn($_), $S[$_], "S$_ doubling rule";
	is sn_build(sub{0}, $_ + 1, $_), $S[$_], "S$_ single iteration";
}

# Finally: task 2: Generate S30.
my $s30;
my $t30 = timeit(1, sub {$s30 = sn 30});
print 'S30: ', $t30->timestr, "\n";
is length($s30), 2**30 - 1, 'check size of S30';

# NB 1:
# When using the sn_extend procedure with l <= k, then all the
# required SI(i) are already contained within S(k).  Thus it is possible
# to generate S(k+l) without accessing anything from the newly generated
# string and thereby exceeding the limit of physical internal memory.
# Here S40 can be generated from S20 within half an hour by writing
# to /dev/null.  S40 has a length of 1 TB.

sub sn_print {
	my $fh = shift;
	local $_;
	*_ = \shift;
	my $upper = 2**(shift() - 1) - 1;

	my $rsw = reverse y/01/10/r;

	for my $i (0 .. $upper) {
		print $fh $_, $i % 2, $rsw;
		print $fh substr($_, $i, 1) if $i < $upper;
	}
}

# Demo for S10
open my $fh, '>', \my $s10 or die;
sn_print $fh, sn(5), 5;
close $fh;
is $s10, sn(10), 'S10 from sn_print';

# As the challenge says "generate SN", but not "store it",
# the following might count as a valid solution to the task of "generate
# S40".
SKIP: {
	skip "S40";
	open my $null, '>', '/dev/null' or die;
	my $t40 = timeit(1, sub {sn_print $null, sn(20), 20});
	print 'S40: ', $t40->timestr, "\n";
	close $null;
# gives here:
#	S40: 1878 wallclock secs (1862.21 usr + 10.90 sys = 1873.11 CPU) @  0.00/s (n=1)
}

# NB 2:
# With the single-stepping rule it is possible to create each SI(i)
# with a very simple recursive procedure.  The required heap size is
# O(1) and the stack size is O(n) for S(n).  But, as this procedure
# becomes painfully slow for larger n, it is of no practical relevance.
# However, here it is:
sub sn_i {
	my $i = shift;
	if ($i % 2 == 0) {
		return ($i / 2) % 2;
	} else {
		return sn_i(($i - 1) / 2);
	}
}

is join('', map {sn_i($_)} (0 .. 2**5 - 2)), sn(5), 'S5 iterative';

done_testing;
