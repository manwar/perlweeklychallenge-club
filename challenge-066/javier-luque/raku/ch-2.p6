# Test: perl6 ch-2.p6
use Test;

sub MAIN() {
    is powers(9),   '3^2',      'Power: 9';
    is powers(16),  '2^4, 4^2', 'Power: 16';
    is powers(45),  '0',        'Power: 45';
    done-testing;
}

sub powers(Int $N) {
    my @answers;

    for (2 .. $N) -> $i {
    	for (2 .. $N) -> $j {
    		if ($i ** $j > $N) {
    			last;
    		} elsif ($i ** $j == $N) {
    			@answers.push($i ~ '^' ~ $j);
    		}
    	}
    }

    return @answers.elems ??
    	@answers.join(", ") !! 0;
}
