-- Perl Weekly Challenge 173
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc173;

CREATE OR REPLACE FUNCTION
pwc173.task1_plperl( int )
RETURNS BOOL
AS $CODE$
my ( $n ) = @_;
return 0 if $n < 10;

my @digits = split //, $n;

for ( 0 .. $#digits - 1 ) {
    return 0 if ( abs( $digits[ $_ ] - $digits[ $_ + 1 ] ) != 1 );
}

return 1;
$CODE$
LANGUAGE plperl;
