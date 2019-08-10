#!/usr/bin/env perl6

# Write a script to print the smallest pair of Amicable Numbers.

say amicable-numbers.first;

sub amicable-numbers {
    return lazy gather {
	my %seen;
	for 1 .. Inf -> $i {
	    my $key = ($i, sum proper-divisors( $i )).sort.join(',');
	    take $key if %seen{ $key }:exists;
	    %seen{ $key } = 1;
	}
    };
}

sub proper-divisors( $i ) {
    return (1 .. $i-1).grep: { $i %% $_ };
}

