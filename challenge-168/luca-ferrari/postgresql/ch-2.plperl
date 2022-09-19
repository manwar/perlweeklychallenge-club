-- Perl Weekly Challenge 168
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc168;

CREATE OR REPLACE FUNCTION
pwc168.task2_plperl( int )
RETURNS int
AS $CODE$

my ( $value ) = @_;

my $is_prime = sub {
   my ( $number ) = @_;

   for ( 2 .. $number - 1 ) {
       return 0 if ( $number % $_ == 0 );
   }

   return 1;
};

my $prime_factors = sub {
   my ( $number ) = @_;
   my @factors;

   return if $is_prime->( $number );

   for ( 2 .. $number - 1 ) {
       next if ! $is_prime->( $_ );
       next if $number % $_ != 0;
       next if $_ > $number;

       while ( ( $number % $_ ) == 0 ) {
             push @factors, $_;
             $number /= $_;
       }
   }

   return @factors;
};


my $value = join( '', $prime_factors->( $value ) );
while ( ! $is_prime->( $value ) ) {
      $value = join( '', $prime_factors->( $value ) );
}

return $value;

$CODE$
LANGUAGE plperl;
