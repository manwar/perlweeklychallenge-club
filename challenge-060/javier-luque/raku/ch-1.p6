# Test: perl6 ch-1.p6 30
sub MAIN(Int $n) {
    say to-excel($n);
}


sub to-excel(Int $n is copy) {
    # Array to store digits
    my @digits;

    # Break down the digits to base 26
    while ($n > 0) {
    	@digits.push(($n-1) % 26);
    	$n = Int( ($n-1)/26 );
    }

    # Join the digits
    return @digits.reverse.map({ chr(ord('A') + .Int) }).join('');
}
