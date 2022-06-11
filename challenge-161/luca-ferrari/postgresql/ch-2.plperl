-- Perl Weekly Challenge 161
CREATE SCHEMA IF NOT EXISTS pwc161;


CREATE OR REPLACE FUNCTION pwc161.pangrams()
RETURNS SETOF text
AS $CODE$
 my @found;
 
 for my $letter ( 'a' .. 'z' ){
   my $query = spi_query( "SELECT word FROM pwc161.dictionary WHERE word like '%$letter%' order by random()" );   

 while ( defined ( $row = spi_fetchrow( $query ) ) ) {
  # first word ever
  push @found, $row->{ word } and return_next( $row->{ word } ) if ! @found;

  next if grep /$letter/, @found;

  # add the word
  push @found, $row->{ word };
  return_next( $row->{ word } );

  }
}

return undef;
$CODE$
LANGUAGE plperl;
