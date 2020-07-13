# Test: perl6 ch-1.p6
sub MAIN(Int $a where $a > 0, Int $b where $b < 10e15) {
    my @answers;
    for ($a .. $b) -> $orig_i {
    	my $i = $orig_i.Str;

    	# Check and remove 6/9, 9/6 0/0, 1/1, 8/8 pairs
    	my $search_length = $i.chars / 2;
    	loop (my $j = 0; $j < $search_length; $j++) {
    		my $p1 = $i.substr($j, 1);
    		my $p2 = $i.substr($i.chars - $j - 1, 1);

    		if ( ($p1 eq '6' && $p2 eq '9') ||
    		     ($p1 eq '9' && $p2 eq '6') ||
    		     ($p1 eq '0' && $p2 eq '0') ||
    		     ($p1 eq '8' && $p2 eq '8') ||
    		     ($p1 eq '1' && $p2 eq '1')) {
    			$i = $i.substr(1, $i.chars - 2);
    			$j--;
    			$search_length--;
    		} else {
    			last;
    		}

    		push @answers, $orig_i
    			unless ($i);
    	}
    }

    say @answers.join(', ' );
}
