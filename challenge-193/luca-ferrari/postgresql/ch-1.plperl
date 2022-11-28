-- Perl Weekly Challenge 193
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc193;

CREATE OR REPLACE FUNCTION
pwc193.task1_plperl( int )
RETURNS SETOF TEXT
AS $CODE$
  my ( $n ) = @_;

  my @bins =
       map { '0' x ( $n - length( $_ ) ) . $_ }
       map { sprintf "%b", $_ }
       ( 0 .. 2 ** $n - 1 );

  return_next( $_ ) for @bins;
  return;
$CODE$
LANGUAGE plperl;
