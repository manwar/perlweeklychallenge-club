-- Perl Weekly Challenge 160

CREATE SCHEMA IF NOT EXISTS pwc160;

/*
testdb=> select pwc160.equilibrium( array[1,2,3,6]::int[] );
 equilibrium 
-------------
           3

*/
CREATE OR REPLACE FUNCTION
pwc160.equilibrium( int[] )
RETURNS int
AS $CODE$
my ( @A ) = @{ $_[0] };

# compute the sum of an array
my $do_sum = sub {
   my ( @a ) = @_;
   my $sum = 0;
   $sum += $_  for ( @a );
   return $sum;
};

for my $index ( 1 .. $#A ) {
    return $index if ( $do_sum->( @A[ 0 .. $index - 1 ] ) == $do_sum->( @A[ $index .. $#A ] ) );
}

return -1;
$CODE$
LANGUAGE plperl;
