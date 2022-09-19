-- Perl Weekly Challenge 174
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc174;

CREATE OR REPLACE FUNCTION
pwc174.task1_plperl( int )
RETURNS SETOF BIGINT
AS $CODE$

my ( $limit ) = @_;
my ( $current ) = 9;
while ( $limit > 0 ) {
     $current++;
     my $index = 0;
     my @digits = map { $_ ** ++$index } split( //, $current );
     my $sum = 0;
     $sum += $_  for ( @digits );

     if ( $current == $sum ) {
        $limit--;
        return_next( $current );
     }
}

return undef;

$CODE$
LANGUAGE plperl;
