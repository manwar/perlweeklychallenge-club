#!/usr/bin/perl

# generate numbers of length $X that are smaller than $Y
# from the parts in @L.
#
# recursive "branch and cut"

use Test2::V0;

# check_num expects:
# - number that has the desired length
# - control hash.
# if the number fits, it is added to the result set.
# cut this branch otherwise
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
		next if $num == 0 && $level == 0;

		$current[$level] = "$num";
		my $stop;

		# construct current value from selected parts
		my $value = join '', @current;
		my $t = length($value) <=> $ctl->{length};
		if ($t < 0) { # $value is too short
			if ($value gt $ctl->{limit}) {
				# cut if current prefix is already too large
				return;
			} else {
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
# Parts are not restricted to single digits.
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
my (@L, $X, $Y, @R);

@L = (0, 1, 2, 5);
$X = 2;
$Y = 21;
@R = create_numbers $X, $Y, @L;
is \@R, [10, 11, 12, 15, 20], 'example from challenge';

@L = (0, 1, 100000002);
$X = 9;
$Y = 100000003;
@R = create_numbers $X, $Y, @L;
is \@R, [100000000, 100000001, 100000002], 'cut example';

done_testing;
