use strict;
use warnings;
use feature qw/say/;

sub is_prime {
    my $num = shift;
    for my $i (2 .. $num ** .5) {
        return 0 if $num % $i == 0;
    }
    return 1;
}
sub count_primes {
    my $n = shift;
    return scalar grep is_prime($_), 2..$n;
}
for my $i (<10 15 1 25>) {
    say "$i \t => ", count_primes $i;
}
