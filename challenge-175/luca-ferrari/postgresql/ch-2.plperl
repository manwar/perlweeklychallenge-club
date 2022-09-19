-- Perl Weekly Challenge 175
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc175;

CREATE OR REPLACE FUNCTION
pwc175.task2_plperl( int )
RETURNS SETOF INT
AS $CODE$

use ntheory qw/euler_phi/;
use Sub::Recursive;

my ( $limit ) = @_;


my $totients = recursive {
   my ( $t ) = @_;
   return euler_phi( $t )
               + ( $t == 2
                      ? 0
                      : $REC->( euler_phi( $t ) ) );
};

for ( 2 .. 99999 ) {
    return_next( $_ ) and $limit-- if ( $_ == $totients->( $_ ) );
    last if $limit <= 0;
}

return undef;

$CODE$
LANGUAGE plperlu;
