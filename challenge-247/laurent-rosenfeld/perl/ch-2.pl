use strict;
use warnings;
use feature 'say';

sub most_frequent_pair {
    my %pairs;
    my @letters = split //, shift;
    for my $i (1..$#letters) {
        my $pair = $letters[$i-1] . $letters[$i];
        $pairs{$pair}++;
    }
    return (sort { $pairs{$b} <=> $pairs{$a} ||
                $a cmp $b } keys %pairs)[0];
}

for my $test ('abcdbca', 'cdeabeabfcdfabgcd', 'bcabbc') {
    printf "%-20s => ", $test;
    say most_frequent_pair $test;
}
