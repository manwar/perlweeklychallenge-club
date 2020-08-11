#!/usr/bin/perl

# sub create_numbers generates numbers
# - of length $X
# - that are smaller than $Y
# - from the parts in @L.
# See below.
#
# Though data has been described as numeric, processing is
# strictly string based. (Example provided.)

use Test2::V0;

# check_num expects:
# - number to be checked
# - control hash.
# If the number fits, it is added to the result set.
# Cut this branch otherwise.
sub check_num {
	my $num = shift;
	my $ctl = shift;
	if ($num lt $ctl->{limit}) {
		return $ctl->{result}{$num} = 1
	};
	0;
}

# Recursively constructs numbers from the given parts.
# gen_num expects:
# - current recursion level
# - config hash
sub gen_num;
sub gen_num {
	my $level = shift;
	my $ctl = shift;

	our @current;
	# localize the array element for the current level,
	# will be auto-deleted at return
	local $current[$level];

	# loop over parts at this level
	foreach my $num (@{$ctl->{parts}}) {
		# skip leading zero
		next if $num eq 0 && $level == 0;

		$current[$level] = "$num";
		my $stop;

		# construct current value from selected parts
		my $value = join '', @current;

		# test length of current value
		my $t = length($value) <=> $ctl->{length};
		if ($t < 0) { # $value is too short
			if ($value ge $ctl->{limit}) {
				# cut if $value is too large
				return;
			} else { # $value is not too large but too short
				# recurse to next level
				gen_num $level + 1, $ctl;
			}
		} elsif ($t == 0) { # $value has desired length
			# cut if $value is too large
			# next cannot lead to something smaller,
			# even if it is shorter
			return unless check_num $value, $ctl;
		}
		# else: $value is too long, next might be shorter
	}
}

# Create numbers of given length, below given limit
# and assembled from given parts.
# Parts are not restricted to single digits (nor to numeric data).
sub create_numbers {
	my $length = shift;
	my $limit = shift;

	# sort parts lexicographically (!)
	my $parts = [sort @_];

	my $ctl = {length => $length, limit => $limit, parts => $parts};

	# enter generator
	gen_num 0, $ctl;
	return sort keys %{$ctl->{result}};
}

# main
my (@L, $X, $Y);

@L = (0, 1, 2, 5);
$X = 2;
$Y = 21;
is [create_numbers $X, $Y, @L], [10, 11, 12, 15, 20],
	'example from challenge';

@L = (0, 1, 100000002);
$X = 9;
$Y = 100000003;
is [create_numbers $X, $Y, @L], [100000000, 100000001, 100000002],
	'avoid too much scanning';

@L = qw(a b c);
$X = 3;
$Y = 'abc';
is [create_numbers $X, $Y, @L], [qw(aaa aab aac aba abb)],
	'non numeric';

@L = (0, 5, 43, 321);
$X = 4;
$Y = 5001;
is [create_numbers $X, $Y, @L],
	[3210, 3215, 4300, 4305, 4343, 4350, 4355, 5000],
	'another example';

done_testing;
