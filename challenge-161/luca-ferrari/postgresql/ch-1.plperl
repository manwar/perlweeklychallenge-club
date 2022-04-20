CREATE SCHEMA IF NOT EXISTS pwc161;

/*
testdb=> create schema pwc161;
cCREATE SCHEMA
testdb=> create table pwc161.dictionary( word text );
CREATE TABLE

$ psql -h miguel -U luca -c 'COPY pwc161.dictionary( word ) FROM STDIN;' testdb < ../../data/dictionary.txt
COPY 39172
*/


CREATE OR REPLACE FUNCTION
pwc161.plperl_abecedarian()
RETURNS SETOF text
AS $CODE$

 my $query = spi_query( 'SELECT word FROM pwc161.dictionary ORDER BY length( word ) ASC' );
 while ( defined ( $row = spi_fetchrow( $query ) ) ) {
  my @letters = split //, $row->{ word };
    return_next( $row->{ word } ) if ( $row->{ word } eq join( '', sort( @letters ) ) );
}

return undef;
$CODE$
LANGUAGE plperl;
