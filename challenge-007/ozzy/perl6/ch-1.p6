#/usr/bin/env perl6

# Print all the niven numbers from 0 to 50 inclusive, each on their own line. 
# A niven number is a non-negative number that is divisible by the sum of its digits.

sub SumDigits ( Int $x is copy ) {
    my $sum=0;
    while $x != 0 {
        $sum += $x mod 10;
        $x= $x div 10;
    }
    return $sum;
}


sub MAIN {
    for 0..50 -> $x {
        say $x if $x %% SumDigits($x);
    }
}
