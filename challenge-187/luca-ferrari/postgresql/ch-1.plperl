-- Perl Weekly Challenge 187
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc187;

CREATE OR REPLACE FUNCTION
pwc187.task1_plperl( text, text, text, text )
RETURNS INT
AS $CODE$
use DateTime;
my ( $foo_start, $foo_end, $bar_start, $bar_end ) = @_;
my @dates;

for ( $foo_start, $foo_end, $bar_start, $bar_end ) {
  $_ =~ / ^ (\d{2}) - (\d{2}) $ /x;
  push @dates, DateTime->new( year => 2022, day => $1, month => $2 );
}

my $days = 0;

if ( DateTime->compare( $dates[ 0 ], $dates[ 3 ] ) > 0
     || DateTime->compare( $dates[ 1 ], $dates[ 2 ] ) < 0 ) {
  # one ends before the begin of the other or viceversa
  $days = 0;
}
else {
  my ( $start, $end );
  $start = DateTime->compare( $dates[ 0 ], $dates[ 2 ] ) <= 0 ? $dates[ 0 ] : $dates[ 2 ];
  $end   = DateTime->compare( $dates[ 1 ], $dates[ 3 ] ) <= 0 ? $dates[ 1 ] : $dates[ 3 ];

  while ( DateTime->compare( $start, $end ) <= 0 ) {
    $days++ if ( DateTime->compare( $start, $dates[ 0 ] ) >= 0
		 && DateTime->compare( $start, $dates[ 1 ] ) <= 0
		 && DateTime->compare( $start, $dates[ 2 ] ) >= 0
		 && DateTime->compare( $start, $dates[ 3 ] ) <= 0 );
    $start = $start->add( days => 1 );
  }
}



return $days;

$CODE$
LANGUAGE plperlu;
