-- Perl Weekly Challenge 160
CREATE SCHEMA IF NOT EXISTS pwc160;
CREATE SCHEMA IF NOT EXISTS pwc160;

/**
 testdb=> select pwc160.four_is_magic( 7 );
 four_is_magic 
---------------
 Seven is 5
 Five is 4
 Four is magic
*/
CREATE OR REPLACE FUNCTION
pwc160.four_is_magic( int )
RETURNS SETOF text
AS $CODE$

my $words = {
   1 => 'One',
   2 => 'Two',
   3 => 'Three',
   4 => 'Four',
   5 => 'Five',
   6 => 'Six',
   7 => 'Seven',
   8 => 'Eight',
   9 => 'Nine',
};


my $stop = 4;
my ( $current ) = @_;

while ( $current != $stop ) {
      my $word = $words->{ $current };
      my $size = length $word;
      $current = $size;

      return_next( "$word is $size" );
}

return_next( $words->{ $stop } . " is magic" );
return undef;
$CODE$
LANGUAGE plperl;
