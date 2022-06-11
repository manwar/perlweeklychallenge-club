CREATE SCHEMA IF NOT EXISTS pwc155;

/**
 * Inspired by Abigail's solution and documentation:
 https://github.com/manwar/perlweeklychallenge-club/pull/5751/commits/8c4b7ad7bd474c48af5bebdb566412d30101f28e
*/
/*
testdb=> select pwc155.pisano_period( 3 );
DEBUG:  Fibonacci is 1,1
DEBUG:  Fibonacci is 1,1,2
DEBUG:  Fibonacci is 1,1,2,3
DEBUG:  3 found on index 4
pisano_period
---------------
8
*/
CREATE OR REPLACE FUNCTION
pwc155.pisano_period( int )
RETURNS integer
AS $CODE$

my @fibonacci;
for ( 1 .. 999999 ) {
    push @fibonacci, 1 if $_ <= 1;
    push @fibonacci, @fibonacci[ -1 ] + @fibonacci[ -2 ];
    elog( DEBUG, "Fibonacci is " . join( ',', @fibonacci ) );
    last if @fibonacci[ -1 ] == $_[0];
}

# get the index
my $index = $#fibonacci + 1;
elog( DEBUG, "$_[0] found on index $index");
return $index * 2 if $_[0] >= 3 and $index % 2 == 0;
return $index * 4 if $_[0] >= 5 and $index % 2 == 1;

$CODE$
LANGUAGE plperl;
