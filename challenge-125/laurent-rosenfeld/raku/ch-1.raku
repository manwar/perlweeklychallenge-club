use v6;

my @squares = map { $_² }, 1..Inf;
my $max = 200;
my $square-set = @squares[0..$max];
my @square-triples = gather {
    for (@squares[0..$max]).combinations(2) -> $comb {
        my $sum = [+] $comb;
        take (|$comb, $sum) if $sum (elem) $square-set;
    }
}
# say @square-triples;
my %look-up = 0 => -1, 1 => -1, 2 => -1;
for @square-triples -> $triple {
    push %look-up, $triple[$_].sqrt => (map { $_.sqrt}, $triple[0..2]) for 0..2;
}
# say %look-up{13};
for 1..20 -> $test {
    say "$test:\t", %look-up{$test};
}
