# Test: perl6 ch-2.p6
multi MAIN() {
    MAIN('25525511135');
}

multi MAIN(Str $str) {
    partition-ip-string($str);
}

# Partition the ip string
sub partition-ip-string (Str $str) {
    my $length = $str.chars - 2;

    # Find all the combinations for the possible ips
    my @dot_positions = (0 .. $length);
    my @combos = @dot_positions.combinations: 3;

    # Process the combinations
    for @combos -> @combo {
    	my $to_test = $str;
    	my $offset = 0;

    	for (@combo) -> $dot_position {
    		my $position =
    			($dot_position + $offset) + 1;

    		# Append to the test string;
    		$to_test =
    			$to_test.substr(0, $position)
    			~ '.' ~
    			$to_test.substr($position);

    		# Offset the string
    		$offset++;
    	}

    	say $to_test
    		if (validate-ip-string($to_test));
    }
}

# Validate the IP String
sub validate-ip-string(Str $str) {
    for $str.split('.') -> $digit {
    	return False if ($digit > 255);
    	return False if ($digit ~~ /^0\d+$/);
    }
    return True;
}
