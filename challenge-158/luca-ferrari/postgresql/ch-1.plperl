CREATE SCHEMA IF NOT EXISTS pwc158;

/*
testdb=> select * from pwc158.add_primes( 100 );
 add_primes 
------------
          1
          2
          3
          5
          7
         11
         23
         29
         41
         43
         47
         61
         67
         83
         89
*/
CREATE OR REPLACE FUNCTION
pwc158.add_primes( int )
RETURNS SETOF int
AS $CODE$

# function to test if a number is prime
my $is_prime = sub {
   my ($value) = @_;
   for my $i ( 2 .. $value - 1 ) {
     return 0 if ( $value % $i == 0 );
   }

  return 1;
};

# disassemble a number into its digits and sum them
my $sum_digits = sub {
   my ($value) = @_;
   my @digits = split //, $value;
   my $sum = 0;
   $sum += $_ for ( @digits );
   return $sum;
};


for my $i ( 1 .. $_[0] ) {
    return_next( $i ) if ( $is_prime->( $i )
                        && $is_prime->( $sum_digits->( $i ) ) );
}

return undef;

$CODE$
LANGUAGE plperl;
