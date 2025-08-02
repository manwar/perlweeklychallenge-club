use strict;
use warnings;
use feature 'say';

sub sum {
    my $sum = 0;
    for my $n (@_) {
        $sum += $n;
    }
    return $sum;
}
sub sum_digits {
    return sum split //, shift;
}

sub luhn {
    my $in = shift;
    $in =~ s/\D+//g;             # remove non-digits
    my @digits = reverse split //, $in; # reverse and split
    for my $i (0..$#digits) {
        next unless $i % 2;   #skip even indices
        my $val = 2 * $digits[$i];
        $digits[$i] = sum_digits $val;
    }
    # valid luhn if sum ends with a 0 (multiple of 10)
    return (sum @digits) % 10 == 0 ? "True" : "False";
}

for my $test ("17893729974", "178a93r729974", "178 9372 9 9 74",
    "4137 8947 1175 5904", "4137 8974 1175 5904") {
    printf "%-25s => ", $test;
    say luhn $test;
}
