-- Perl Weekly Challenge 190
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc190;

CREATE OR REPLACE FUNCTION
pwc190.task1_plperl( text )
RETURNS int
AS $CODE$
 my ( $word ) = @_;
 return 1 if ( $word =~ / ^ [A-Z] [a-z]+ $ /x
             || $word =~ / ^ [a-z]+ $ /x
	     || $word =~ / ^ [A-Z]+ $ /x );

 return 0;
$CODE$
LANGUAGE plperl;
