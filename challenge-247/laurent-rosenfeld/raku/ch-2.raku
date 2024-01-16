sub most-frequent-pair ($str) {
    my %pairs;
    my @letters = $str.comb;
    for 1..@letters.end -> $i {
        my $pair = @letters[$i-1] ~ @letters[$i];
        %pairs{$pair}++;
    }
    return (sort { %pairs{$^b} <=> %pairs{$^a} ||
                $^a leg $^b }, %pairs.keys)[0];
}

for 'abcdbca', 'cdeabeabfcdfabgcd', 'bcabbc' -> $test {
    printf "%-20s => ", $test;
    say most-frequent-pair $test;
}
