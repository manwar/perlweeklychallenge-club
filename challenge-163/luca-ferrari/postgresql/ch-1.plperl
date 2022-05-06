-- Perl Weekly Challenge 163
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc163;

CREATE OR REPLACE FUNCTION
pwc163.task1_plperl( int[] )
RETURNS int
AS $CODE$
my ( $n ) = @_;

my $sum = 0;
for my $index ( 1 .. scalar( @$n ) - 1 ) {
    my ( $a, $b ) = ( sprintf( '%03b', $n->[ $index - 1 ] ), sprintf( '%03b', $n->[ $index ] ) );
    my $result = $a & $b;

    elog( DEBUG, "Nums $n->[ $index - 1 ] and $n->[ $index ] => $a and $b => $result" );

    $sum += oct( '0b'. $result );
}

my ( $a, $b ) = ( sprintf( '%03b', $n->[ 0 ] ), sprintf( '%03b', $n->[ -1 ] ) );
my $result = $a & $b;
$sum += oct( '0b'. $result );

return $sum;

$CODE$
LANGUAGE plperl;
