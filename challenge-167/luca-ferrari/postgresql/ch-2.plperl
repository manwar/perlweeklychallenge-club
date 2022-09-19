-- Perl Weekly Challenge 167
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc167;

CREATE OR REPLACE FUNCTION
pwc167.task2_plperl( numeric )
RETURNS numeric
AS $CODE$

my @coeffs = qw/
    1.000000000000000174663
    5716.400188274341379136
  -14815.30426768413909044
   14291.49277657478554025
  -6348.160217641458813289
   1301.608286058321874105
  -108.1767053514369634679
   2.605696505611755827729
  -0.7423452510201416151527e-2
   0.5384136432509564062961e-7
  -0.4023533141268236372067e-8
    /;


my $sum_coeffs = 0;
$sum_coeffs += $_ for ( @coeffs );

my $gamma = sub {
   my ($z) = @_;
   my $pi = 3.1415;
   
    if ( $z < 0.5 ) {
        $pi / sin( $pi * $z ) / gamma( $z - 1 );
    }
    else {
        sqrt( 2 * $pi )
        * ( $z + 9 - 0.5) ** ( $z  - 0.5)
        * exp( -1 * ( $z + 9 - 0.5))
        *  do {
            my ($sum, $i) = (shift(@coeffs), 0);
            $sum += $_ / ($z + $i++) for @coeffs;
            $sum;
        };
    }

};


return $gamma->( $_[0] );

$CODE$
LANGUAGE plperl;
