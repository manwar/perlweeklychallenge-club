use Modern::Perl;
use ntheory qw<is_prime>;

my @cuban_primes;
my $cuban = 0;
for ( my $i = 0 ; $cuban <= 1000 ; $i++ ) {
    $cuban = ($i + 1)**3 - $i**3;

    push @cuban_primes, $cuban if is_prime $cuban;
}
say join ', ', @cuban_primes;
