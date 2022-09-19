use strict;
use warnings;
use feature "say";

my @small_primes = (2, 3, 5, 7, 11, 13, 17, 19, 23, 29);

sub combine {
    my @primes = @_;
    my %part_result;
    for my $i (0..$#primes) {
        for my $j ($i..$#primes) {
            $part_result{$primes[$i] * $primes[$j]} = 1;
        }
    }
    return sort {$a <=> $b} keys %part_result;
}
my @result = combine @small_primes[0..3];
push @result, combine @small_primes[4..9];
say "@result[0..19]";
