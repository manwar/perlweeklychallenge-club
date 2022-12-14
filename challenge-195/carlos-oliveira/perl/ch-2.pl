use strict;
use warnings;

sub mostFrequentEven {
    my @numbers = sort @_;
    my $currentNumber = $numbers[0];
    my $maxEven = -1;
    my $maxCount = 0;
    my $currentCount = 0;
    for my $elem (@numbers) {
        next if $elem % 2;
        if ($currentNumber == $elem) {
            $currentCount++;
        } else {
            $currentCount = 1;
            $currentNumber = $elem;
        }
        if ($currentCount > $maxCount) {
            $maxEven = $elem;
            $maxCount = $currentCount;
        }
    }
    return $maxEven;
}

print mostFrequentEven(1,1,2,6,2), "\n";
print mostFrequentEven(1,3,5,7), "\n";
print mostFrequentEven(6,4,4,6,1), "\n";
print mostFrequentEven(6,4,4,6,1,8,8,8), "\n";

