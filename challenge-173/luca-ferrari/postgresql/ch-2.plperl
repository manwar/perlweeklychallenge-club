-- Perl Weekly Challenge 173
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc173;

CREATE OR REPLACE FUNCTION
pwc173.task2_plperl( int )
RETURNS SETOF BIGINT
AS $CODE$

my ( $limit ) = @_;

my @sly = ( 2, 3 );

return_next( $sly[ 0 ] );
return_next( $sly[ 1 ] );

while ( $#sly < $limit ) {
      my $new_value = 1;
      $new_value *= $_ for (@sly);
      push @sly, ++$new_value;
      return_next( $new_value );
}

return undef;

$CODE$
LANGUAGE plperl;
