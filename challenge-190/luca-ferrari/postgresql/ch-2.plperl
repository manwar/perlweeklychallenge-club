-- Perl Weekly Challenge 190
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc190;

CREATE OR REPLACE FUNCTION
pwc190.task2_plperl( text )
RETURNS text
AS $CODE$
 my ( $number ) = @_;
 my @decoded;
 my %decode_table = map { ( $_ + 1 ) => ( 'A' .. 'Z' )[ $_ ] } ( 0 .. 9 );
 for my $current ( split '', $number ) {
     push @decoded, $decode_table{ $current };
 }

return join( '', @decoded );
$CODE$
LANGUAGE plperl;
