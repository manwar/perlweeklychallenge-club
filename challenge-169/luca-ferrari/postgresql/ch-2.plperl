-- Perl Weekly Challenge 169
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc169;

CREATE OR REPLACE FUNCTION
pwc169.task2_plperl( int )
RETURNS SETOF int
AS $CODE$
   use Math::BigInt;

   
   my ($limit) = @_;

  my $is_prime = sub {
     my ($value) = @_;

     for ( 2 .. $value - 1 ) {
         return 0 if $value % $_ == 0;
     }

     return 1;
  };

  my $compute_factors = sub {
     my ($value) = @_;
     my @factors;
     
     for ( 2 .. $value - 1 ) {
         next if ! $is_prime->( $_ );

         while ( $value % $_ == 0 ) {
               push @factors, $_;
               $value /= $_;
         }
     }

     return @factors;
  };

  my $min = sub {
     my $found = shift @_;
     for ( @_ ) {
         $found = $_ if $_ < $found;
     }

     return $found;
  };

  my $is_achille = sub {
     my ($number) = @_;
     my $bag = {};

     for ( $compute_factors->( $number ) ) {
         $bag->{ $_ }++;
     }

    return $min->( values( %$bag ) ) >= 2 && Math::BigInt::bgcd( values( %$bag ) )->numify == 1;
  };


  for ( 1 .. 999999 ) {
    if ( $is_achille->( $_ ) ) {
       $limit--;
       return_next( $_ );
    }

    last if ! $limit;
  }

  return undef;
  
$CODE$
LANGUAGE plperlu;
