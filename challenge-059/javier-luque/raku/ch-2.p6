# Test: perl6 ch-2.p6 2 3 4
sub MAIN(*@ARGV) {
    my @combos = @ARGV.combinations: 2;
    my $answer = 0;

    for @combos -> $combo {
    	$answer += f($combo[0], $combo[1]);
    }

    say $answer;
}

sub f(Int $a, Int $b) {
    return calculate-true-bits($a +^ $b);
}

# Calculate the number of true bits
sub calculate-true-bits(Int $n is copy) {
    my $count = 0;

    repeat {
    	$count++ if ($n +& 1);
    } while ($n = $n +> 1);

    return $count;
}
