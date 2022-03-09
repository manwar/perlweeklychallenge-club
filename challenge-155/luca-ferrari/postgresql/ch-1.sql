CREATE SCHEMA IF NOT EXISTS pwc155;

/*
testdb=> select pwc155.fortunate( 8 ) order by 1;
fortunate
-----------
3
5
7
13
17
19
23
37
(8 rows)


*/

CREATE OR REPLACE FUNCTION
pwc155.fortunate( int )
RETURNS SETOF integer
AS $CODE$

# a subroutine to see if a number
# is prime
my $is_prime = sub {
   return 1 if $_[0] == 1;
   return 1 if $_[0] == 2;
   for my $i ( 2 .. $_[0] - 1 ) {
       return 0 if $_[0] % $i == 0;
   }

   return 1;
};

# generates the first n primes
my $generate_primes = sub {
   my @primes;
   for my $p ( 2 .. 99999 ) {
       push @primes, $p if $is_prime->( $p );
       return @primes if @primes == $_[0];
   }
};

my $max = sub {
   my $max = 0;
   for (@_) {
       $max = $_ if $_ > $max;
   }

   elog( DEBUG, "MAX = $max  in " . join( ',', @_ ) );
   return $max;
};


my $pn = sub {
   my $result = 1;
   for ( @_ ) {
       $result *= $_;
   }

   return $result;
};

my $limit = $_[0] || 8;
my %unique;

for my $n ( 1 .. 999999 ) {
    # generate the first n primes
    my @primes = $generate_primes->( $n );
    my $start  = $max->( @primes ) + 1;
    elog( DEBUG, "Primes = " . join( ',', @primes ) . " with max = $start" );
    for my $m ( $start .. 999999 ) {
         my $fortunate = $pn->( @primes ) + $m;
         elog( DEBUG, "Computing $m -> " . $pn->( @primes ) . " + $m = $fortunate = " . $is_prime->( $fortunate ) );
         next if ! $is_prime->( $fortunate );
         $unique{ $m }++;
         next if $unique{ $m } > 1;
         return_next( $m );
         last;
    }


    $limit--;
    last if $limit <= 0;

}



return undef;
$CODE$
LANGUAGE plperl;
