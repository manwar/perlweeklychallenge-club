CREATE SCHEMA IF NOT EXISTS pwc198;

CREATE OR REPLACE FUNCTION
pwc198.task2_plperl( int )
RETURNS int
AS $CODE$
   my ( $n ) = @_;

   my $is_prime = sub {
      for ( 2 .. $_[0] - 1 ) {
      	  last if $_ * 2 > $_[0]; 
      	  return 0 if $_[0] % $_ == 0;
      }

      return 1;
   };

   my $counter = 0;
   $counter += $is_prime->( $_ )  for ( 2 .. $n );

   return $counter;
$CODE$
LANGUAGE plperl;
