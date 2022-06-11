CREATE SCHEMA IF NOT EXISTS pwc159;

CREATE OR REPLACE FUNCTION
pwc159.farey( int )
RETURNS SETOF text
AS $CODE$
   my ($n) = @_;

   my %farey;

   for my $denominator ( 2 .. $n ) {
       for my $number ( 1 .. $denominator ) {

           # reduce things like 2/4 to 1/2
          ( $denominator, $number ) /= $number       if ( $denominator % $number == 0 );
          ( $denominator, $number ) /= $denominator  if ( $number % $denominator == 0 );
           
           $farey{ $number/$denominator } = "$number/$denominator";
       }
   }

   # bootstrap
   return_next( '0/1' );

   my %unique_counter;
   for my $key ( sort keys( %farey ) ) {
       # ensure only one item is printed out
       $unique_counter{ $key }++;
       next if $unique_counter{ $key } > 1;
       next if $key == 1;  # last term in the sequence
       
       return_next( $farey{ $key } );
   }

   # end term
   return_next( '1/1' );
   return undef;
$CODE$
LANGUAGE plperl;
