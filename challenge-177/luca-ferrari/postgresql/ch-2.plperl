-- Perl Weekly Challenge 177
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc177;

CREATE OR REPLACE FUNCTION
pwc177.task2_plperl( int )
RETURNS SETOF INT
AS $CODE$

my ( $limit ) = @_;

for my $current ( 100 .. 999999 ) {
    next if length( $current ) % 2 == 0;
    next if $current != reverse( $current );
    next if ( split( //, $current) )[ length( $current ) / 2 ] != 0;
    

    $limit-- and return_next( $current );
    last if $limit <= 0;
}

return undef;

$CODE$
LANGUAGE plperl;
