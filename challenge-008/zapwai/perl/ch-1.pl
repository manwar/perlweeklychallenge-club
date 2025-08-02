use v5.36;
use List::Util qw( sum );

sub is_perfect ($num) {
    my @div = grep { $num % $_ == 0 } (1 .. int $num/2);
    return ($num == sum @div);
}

sub get_primes($cap) {
    my @primes = (2);
    for my $num (3 .. $cap) {
	my $cnt = 0;
	for my $p (@primes) {
	    $cnt++ if ($num % $p != 0);
	}
	push @primes, $num if ($cnt == @primes);
    }
    return @primes;
}

my @primes = get_primes(15);
my @input = map { 2**($_ - 1) * (2**$_ - 1) } @primes; 
say join(" ", grep is_perfect($_), @input);

