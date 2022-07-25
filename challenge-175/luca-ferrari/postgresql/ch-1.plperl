-- Perl Weekly Challenge 175
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc175;

CREATE OR REPLACE FUNCTION
pwc175.task1_plperl( int )
RETURNS SETOF DATE
AS $CODE$

use DateTime;
my ( $year ) = @_;

for ( 1 .. 12 ) {
    my $day = DateTime->last_day_of_month( year => $year, month => $_ );
    $day->add( days => -1 ) while( $day->dow != 7 );
    return_next( $day->ymd );
    ;
}

return undef;
$CODE$
LANGUAGE plperlu;
