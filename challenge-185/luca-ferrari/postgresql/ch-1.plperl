-- Perl Weekly Challenge 185
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc185;

CREATE OR REPLACE FUNCTION
pwc185.task1_plperl( text )
RETURNS text
AS $CODE$
my ( $input ) = @_;

$input =~ s/\./g/;

my ( $counter, $output ) = ( 1, '' );
for ( split( //, $input ) ) {
    $output .= $_;
    $output .= ':' if $counter % 2 == 0;
    $counter++;
}

return $output;
$CODE$
LANGUAGE plperl;
