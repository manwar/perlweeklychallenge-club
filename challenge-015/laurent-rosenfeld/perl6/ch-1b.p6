use v6;

my @p = grep { .is-prime }, 1..*;   # Lazy infinite list of primes
sub mapper(UInt $i) {
    @p[$i] > (@p[$i - 1] + @p[$i + 1])/2 ?? 'Strong' !!
    @p[$i] < (@p[$i - 1] + @p[$i + 1])/2 ?? 'Weak'   !!
    'Balanced';
}
my %categories = categorize &mapper, 1..120;
for sort keys %categories -> $key {
    say "$key primes:  ", map {@p[$_]}, %categories{$key}[0..9];
}
