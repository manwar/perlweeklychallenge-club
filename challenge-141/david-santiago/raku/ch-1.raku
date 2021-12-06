#!/usr/bin/env raku

sub MAIN($how-many is copy, $divisors){

    my $last-found = 0;
    my %divisors;
    repeat {
	my $counter = floor(++$last-found / 2 ) + 1;
	my @divisors;
	
	while --$counter {
	    if %divisors{$counter}:exists {
		@divisors.append(%divisors{$counter});
		last;
	    } elsif $last-found % $counter == 0 {
		@divisors.append($counter);
	    }
	}
	
	if @divisors.elems == $divisors - 1 { # all the numbers are divisble by themselves
	    say "Found $last-found: [{@divisors}]";
	    $how-many--;
	}
    } while $how-many
}
