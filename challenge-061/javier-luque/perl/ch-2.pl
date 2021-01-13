#!/usr/bin/perl
# Test: ./ch-2.pl
use strict;
use warnings;
use feature qw /say/;
use Algorithm::Combinatorics qw(combinations);

my $ip_address = $ARGV[0] || '25525511135';
partition_ip_string($ip_address);

# Partition the ip string
sub partition_ip_string {
    my $string = shift;
    my $length = length($string) - 2;

    # Validate string
    return undef if
    	( length($string) < 4  ||
    	  length($string) > 12 ||
    	  !($string =~ /^\d+$/)
    	);

    # Find all the combinations for the possible ips
    my @dot_positions = (0 .. $length);
    my $iter = combinations(\@dot_positions, 3);

    # Process the combinations
    while (my $combos = $iter->next) {
    	my $to_test = $string;
    	my $offset = 0;

    	for my $dot_position (@$combos) {
    		my $position =
    			($dot_position + $offset) + 1;

    		# Append to the test string;
    		$to_test =
    			(substr $to_test, 0, $position)
    			. '.' .
    			(substr $to_test, $position);

    		# Offset the string
    		$offset++;
    	}

    	say $to_test
    		if (validate_ip_string($to_test));
    }
}

# Validate the IP String
sub validate_ip_string {
    for my $digit (split('\.', shift)) {
    	return 0 if ($digit > 255);
    	return 0 if ($digit =~ /^0\d+$/);
    }

    return 1;
}
