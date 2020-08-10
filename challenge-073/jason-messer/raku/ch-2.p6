#! /usr/bin/env rakudo

my @A = (7, 8, 3, 12, 10);
my @B = (4, 5, 6);

# find min number in @A[0..n-1] that is less than n
sub min-left-lt(@array) {
	gather for (@array) {
		state @left;
		my $min = min(@left);

		if $min < $_ { take $min }
		else { take 0 }

		@left.append($_);
	}
}

say min-left-lt(@A);
say min-left-lt(@B);
