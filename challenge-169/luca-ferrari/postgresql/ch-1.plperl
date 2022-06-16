-- Perl Weekly Challenge 169
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc169;

CREATE OR REPLACE FUNCTION
pwc169.task1_plperl( int )
RETURNS SETOF int
AS $CODE$
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


  for ( 1 .. 9999999 ) {
      my @factors = $compute_factors->( $_ );
      elog( DEBUG, "Number $_ with factors " . join(',', @factors) );
      next if ( @factors != 2 );
      next if $factors[ 0 ] == $factors[ 1 ];
      if ( length( $factors[ 0 ] ) == length( $factors[ 1 ] ) ) {
         $limit--;
         return_next( $_ );
      }
      
      last if ! $limit;
  }

  return undef;
$CODE$
LANGUAGE plperl;
