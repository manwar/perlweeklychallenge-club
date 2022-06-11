CREATE SCHEMA IF NOT EXISTS pwc154;

CREATE TABLE IF NOT EXISTS
pwc154.permutations
(
  pk int generated always as identity
  , perm text not null
  , primary key( pk )
);

TRUNCATE pwc154.permutations;

INSERT INTO pwc154.permutations( perm )
VALUES
( 'PELR' ),
( 'PREL' ),
( 'PERL' ),
( 'PRLE' ),
( 'PLER' ),
( 'PLRE' ),
( 'EPRL' ),
( 'EPLR' ),
( 'ERPL' ),
( 'ERLP' ),
( 'ELPR' ),
( 'ELRP' ),
( 'RPEL' ),
( 'RPLE' ),
( 'REPL' ),
( 'RELP' ),
( 'RLPE' ),
( 'RLEP' ),
( 'LPER' ),
( 'LPRE' ),
( 'LEPR' ),
( 'LRPE' ),
( 'LREP' )
;


CREATE OR REPLACE FUNCTION pwc154.all_permutations( text )
RETURNS SETOF text
AS $CODE$
 use List::Permutor;
 my @letters = split( //, $_[ 0 ] );
 my $engine  = List::Permutor->new( @letters );
 while ( my @permutation = $engine->next() ) {
    my $current = join( '', @permutation );
    return_next( join( '', @permutation ) );
 }

 return undef;
$CODE$
LANGUAGE plperlu;


CREATE OR REPLACE FUNCTION pwc154.find_missing_permutations( text )
RETURNS SETOF text
AS $CODE$
  elog( INFO, "SELECT perm FROM pwc154.all_permutations( $_[ 0 ] ) WHERE perm NOT IN ( SELECT perm FROM pwc154.permutations )" );
  my $result_set = spi_exec_query( "SELECT perm FROM pwc154.all_permutations( " . quote_literal( $_[ 0 ] ) . " ) t(perm) WHERE perm NOT IN ( SELECT perm FROM pwc154.permutations )" );
  for my $i ( 0 .. $result_set->{ processed } ) {
      return_next( $result_set->{ rows }[ $i ]->{ perm } );
  }
  return undef;
$CODE$
language plperl;
