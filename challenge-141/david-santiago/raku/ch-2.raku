#!/usr/bin/env raku

sub MAIN($digits, $divisor) {
    my @digits = $digits.comb;
    my $max-size = @digits.elems - 1;
    
    my @combinations = @digits.combinations.grep: {$_.elems <= $max-size && $_.elems > 0};
    my @results;
    for @combinations -> @numbers {
	my Int $candidate = @numbers.join.Int;
	@results.append($candidate) if $candidate % $divisor == 0;
    }
    say "{@results.elems}: {@results}";
}
