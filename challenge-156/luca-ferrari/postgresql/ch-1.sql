CREATE SCHEMA IF NOT EXISTS pwc156;

CREATE OR REPLACE FUNCTION
pwc156.is_prime( int )
RETURNS bool
AS $CODE$
   return 0 if $_[0] <= 1;
   for my $i ( 2 .. $_[0] - 1 ) {
       return 0 if $_[0] % $i == 0;
   }

   return 1;
$CODE$
LANGUAGE plperl;


CREATE OR REPLACE FUNCTION
pwc156.sumbits( int[] )
RETURNS int
AS $CODE$
   my $sum = 0;
   for my $bit ( @{$_[0]} ) {
       $sum += $bit;
   }

   return $sum;
$CODE$
LANGUAGE plperl;



SELECT n
FROM generate_series( 1, 1000 ) n
WHERE pwc156.is_prime( pwc156.sumbits( regexp_split_to_array( n::bit(10)::text, '' )::int[] ) )
LIMIT 10;
