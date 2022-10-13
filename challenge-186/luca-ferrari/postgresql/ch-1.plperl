-- Perl Weekly Challenge 186
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc186;


/*
testdb=> select pwc186.task1_plperl( array['a', 'b', 'c']::text[], array['1','2','3']::text[] );
 task1_plperl  
---------------
 {a,1,b,2,c,3}

*/

CREATE OR REPLACE FUNCTION
pwc186.task1_plperl( text[], text[] )
RETURNS text[]
AS $CODE$
my ( $left, $right ) = @_;

my $zip = sub {
   my ( $left, $right ) = @_;
   my $zipped = [];

   while ( $left->@* ) {
         push $zipped->@*, shift $left->@*, shift $right->@*;
   }

   return $zipped;
  };

  return $zip->( $left, $right );
$CODE$
LANGUAGE plperl;
