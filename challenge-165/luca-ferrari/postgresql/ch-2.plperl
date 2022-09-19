-- Perl Weekly Challenge 165
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc165;

CREATE TABLE IF NOT EXISTS points( x1 int, y1 int, x2 int, y2 int );

TRUNCATE points;

INSERT INTO points( x1, y1 )
VALUES
(333,129) ,( 39,189) ,(140,156) ,(292,134) ,(393,52 ) ,(160,166) ,(362,122) ,( 13,193)
,(341,104) ,(320,113) ,(109,177) ,(203,152) ,(343,100) ,(225,110) ,( 23,186) ,(282,102)
,(284,98)  ,(205,133) ,(297,114) ,(292,126) ,(339,112) ,(327,79 ) ,(253,136) ,( 61,169)
,(128,176) ,(346,72 ) ,(316,103) ,(124,162) ,( 65,181) ,(159,137) ,(212,116) ,(337,86 )
,(215,136) ,(153,137) ,(390,104) ,(100,180) ,( 76,188) ,( 77,181) ,( 69,195) ,( 92,186)
,(275,96)  ,(250,147) ,( 34,174) ,(213,134) ,(186,129) ,(189,154) ,(361,82 ) ,(363,89 )  
;


CREATE OR REPLACE FUNCTION
pwc165.task2_plperl( text )
RETURNS TEXT
AS $CODE$

my ( $filename ) = @_;
my ( $m, $x, $y, $xy, $xx ) = 0,0,0,0,0;
my @points;

my $result_set = spi_exec_query( 'select x1, y1 from points' );
for my $index ( 0 .. $result_set->{ processed } - 1 ) {
  my $row = $result_set->{ rows }[ $index ];
  push @points, [ $row->{ x1 }, $row->{ y1 } ];
}


$x  += $_->[ 0 ] for ( @points );
$y  += $_->[ 1 ] for ( @points );
$xy += $_->[ 0 ] * $_->[ 1 ] for ( @points );
$xx += $_->[ 0 ] * $_->[ 0 ] for ( @points );
$m   = ( $#points * $xy - $x * $y ) / ( $#points * $xx - $x * $x );

my $b = 0;
$b = ( $y - $m * $x ) / $#points;

elog( DEBUG, "y = $m * x + $b" );

# compute two points in the line
my ( $x1, $y1, $x2, $y2 ) = ( 0, $b, 100, 100 * $m + $b );
# insert the line
spi_exec_query( "INSERT INTO points( x1, y1, x2, y2 ) VALUES( $x1, $y1, $x2, $y2 ); " );

# now call the other function to plot the graph
spi_exec_query( sprintf "SELECT pwc165.plperl_generate_svg_xml( '%s' );", $filename );
return( $filename );

$CODE$
LANGUAGE plperl;
