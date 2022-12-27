-- Perl Weekly Challenge 197
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc197;

CREATE OR REPLACE FUNCTION
pwc197.task2_plperl( int[] )
RETURNS int[]
AS $CODE$
my ( $array ) = @_;
my $sorted = [ $array->@* ];
my $need_swap = 1;

while ( $need_swap ) {
  $need_swap = 0;
  for my $i ( 0 .. $sorted->@* - 1 ) {
    my $need_swap = ( ( $i % 2 == 0 ) && ( $sorted->[ $i ] >= $sorted->[ $i + 1 ] ) )
                    || ( ( $i % 2 != 0 ) && ( $sorted->[ $i ] <= $sorted->[ $i + 1 ] ) );

   if ( $need_swap ) {
      my $temp = $sorted->[ $i ];
      $sorted->[ $i ] = $sorted->[ $i + 1 ];
      $sorted->[ $i + 1 ] = $temp;
   }

    
 }
}

return $sorted;

$CODE$
LANGUAGE plperl;
