-- Perl Weekly Challenge 171
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc171;

CREATE OR REPLACE FUNCTION
pwc171.task2_f( text )
RETURNS TEXT
AS $CODE$
   elog( DEBUG, "F( $_[0] )" );
   return $_[0];
$CODE$
LANGUAGE plperl;


CREATE OR REPLACE FUNCTION
pwc171.task2_g( text )
RETURNS TEXT
AS $CODE$
   elog( DEBUG, "G( $_[0] )" );
   return $_[0];
$CODE$
LANGUAGE plperl;


/*
testdb=> select * from pwc171.task2_plperl( 'pwc171.task2_f', 'pwc171.task2_g', 'Hello World' );
DEBUG:  Query [SELECT pwc171.task2_f( pwc171.task2_g( 'Hello World' ) ) AS compose;]
DEBUG:  G( Hello World )
DEBUG:  F( Hello World )
 task2_plperl 
--------------
 Hello World
*/
CREATE OR REPLACE FUNCTION
pwc171.task2_plperl( text, text, text )
RETURNS TEXT
AS $CODE$



my $compose = sub {
   my $query = sprintf( "SELECT %s( %s( '%s' ) ) AS compose;",
               $_[ 0 ],
               $_[ 1 ],
               $_[ 2 ] );
   elog( DEBUG, "Query [$query]" );
   my $result_set = spi_exec_query( $query );
   return $result_set->{ rows }[ 0 ]->{ compose };
};

return $compose->( @_ );
$CODE$
LANGUAGE plperl;
