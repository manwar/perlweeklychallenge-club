-- Perl Weekly Challenge 182
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc182;

CREATE OR REPLACE FUNCTION
pwc182.task1_plperl( int[] )
RETURNS int
AS $CODE$
   my ($index, $max_value);
   my $current_index = -1;
   for ( @{ $_[0] } ) {
       $current_index++;
       ( $index, $max_value ) = ( $current_index, $_ ) if ( ! $max_value || $_ > $max_value  );
   }

   return $index;
   
$CODE$
LANGUAGE plperl;
