-- Perl Weekly Challenge 171
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc171;

/*
testdb=> select pwc171.task1_plperl( 20 );
 task1_plperl 
--------------
          945
         1575
         2205
         2835
         3465
         4095
         4725
         5355
         5775
         5985
         6435
         6615
         6825
         7245
         7425
         7875
         8085
         8415
         8505
         8925
(20 rows)
*/
CREATE OR REPLACE FUNCTION
pwc171.task1_plperl( int )
RETURNS SETOF INT
AS $CODE$
my ($limit) = @_;

my $is_abundant = sub {
   my ( $n ) = @_;
   my @divisors = ( 1 );

   for ( 2 .. $n / 2 ) {
       next if $n % $_ != 0;
       push @divisors, $_;
   }

   my $sum = 0;
   $sum += $_ for ( @divisors );

   return $sum > $n;
};


for ( 1 .. 99999 ) {
    next if $_ % 2 == 0;
    if ( $is_abundant->( $_ ) ) {
       $limit--;
       return_next( $_ );
    }

    last if $limit <= 0;
}

return undef;

$CODE$
LANGUAGE plperl;
