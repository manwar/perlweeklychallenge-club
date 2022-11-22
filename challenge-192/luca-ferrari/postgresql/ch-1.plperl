-- Perl Weekly Challenge 192
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc192;

CREATE OR REPLACE FUNCTION
pwc192.task1_plperl( int)
RETURNS int
AS $CODE$
  my ($n) = @_;


  my @bits = map { $_ == 0 ? 1 : 0 } split( '', sprintf( "%b", $n ) );
  my $binary = join( '', @bits );
  my $flipped = eval( "0b$binary" );
  return $flipped;
$CODE$
LANGUAGE plperl;
