-- Perl Weekly Challenge 163
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc163;

CREATE OR REPLACE FUNCTION
pwc163.task2_plperl( int[] )
RETURNS int
AS $CODE$

my ( $n ) = @_;
my @matrix;

push @matrix, [ @$n ];
 while ( scalar( @{ $matrix[ -1 ] } ) > 2 ) {
      my @row;
      push @row, $matrix[ -1 ][ 1 ];
      for my $index ( 2 .. scalar( @{ $matrix[ -1 ] } ) - 1 ) {
          push @row,  $matrix[ -1 ][ $index ] + $row[ -1 ];
      }

      elog( DEBUG, "Current row: " . join( ',', @row ) );
      push @matrix, [ @row ];
 }

return $matrix[ -1 ][ -1 ];
$CODE$
LANGUAGE plperl;
