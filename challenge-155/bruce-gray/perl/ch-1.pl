use Modern::Perl;
use experimental qw<signatures>;
use bigint;
use List::Lazy   qw<lazy_list>;
use List::Util   qw<first uniq>;
use ntheory      qw<next_prime prime_iterator_object>;

# Variable names are from https://mathworld.wolfram.com/FortunatePrime.html

my $pi = prime_iterator_object(); # Primes will be bigint when needed.

my $prime_products = lazy_list { $_ *= $pi->iterate() } 1;

my $Ek = $prime_products->map( sub { $_ + 1 } );

my $Fk = $Ek->map( sub { next_prime($_) - $_ + 1 } );



my $N = shift // 8;

my @out;
while (@out < $N) {
    push @out, $Fk->next( $N - @out);
    @out = uniq sort { $a <=> $b } @out;
}
say join ' ', @out[0 .. $N-1];
